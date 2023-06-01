import 'dart:async';
import 'dart:io';

/// stdout.write
class LoggerUtil {
  static LoggerUtil? _instance;

  /// instance
  static LoggerUtil get shared {
    _instance ??= LoggerUtil();
    return _instance!;
  }

  bool get _supportAnsiEscapes =>
      stdout.supportsAnsiEscapes && stdout.hasTerminal;

  Timer? _timer;

  final List<String> _loadingChars = ['|', '/', '-', '\\'];

  /// print a progress
  void progress(String message) {
    stdout.write('$message...');
    if (!_supportAnsiEscapes) return;
    stdout.write(_loadingChars.first);
    // add a escape sequences timer
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      stdout.write('\b${_loadingChars[timer.tick % _loadingChars.length]}');
    });
  }

  /// finish progress
  void finish() {
    _timer?.cancel();
    if (_supportAnsiEscapes) stdout.write('\b');
    stdout.writeln('done');
  }
}

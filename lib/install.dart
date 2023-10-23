import 'dart:io';
import 'package:hooklint/constants/shell.dart';
import 'package:hooklint/utils/pubspec_util.dart';

/// install git pre-commit hook
Future<void> install() async {
  // get .git/hooks
  final ProcessResult result =
      Process.runSync('git', ['rev-parse', '--git-dir']);
  if (result.stdout is! String || (result.stdout as String).isEmpty) {
    print('not a git repository');
    return;
  }

  final File preCommitHook =
      File('${(result.stdout as String).trim()}/hooks/pre-commit');
  if (preCommitHook.existsSync()) {
    // back up existing pre-commit
    final File backup = File(
        '${preCommitHook.path}.bak.${DateTime.now().millisecondsSinceEpoch}');
    backup.writeAsStringSync(preCommitHook.readAsStringSync());
  }
  // write hook
  preCommitHook.writeAsStringSync(
      PubspecUtil.shared.hasDependency ? localTemplate : globalTemplate);

  // 添加执行权限
  final chmodResult = Process.runSync('chmod', ['+x', preCommitHook.path]);
  stdout.write(chmodResult.stdout);
  stderr.write(chmodResult.stderr);
}

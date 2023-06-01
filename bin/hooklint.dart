import 'package:hooklint/install.dart';
import 'package:hooklint/run.dart';

enum Command {
  install,
  run,
}

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('--help');
    return;
  }

  if (arguments.first == Command.install.name) {
    install();
    return;
  }

  if (arguments.first == Command.run.name) {
    run();
    return;
  }
}

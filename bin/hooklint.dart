import 'package:hooklint/constants/command.dart';
import 'package:hooklint/install.dart';
import 'package:hooklint/run.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty || Command.run.be(arguments.first)) {
    run();
    return;
  }

  if (Command.install.be(arguments.first)) {
    install();
    return;
  }

  print(commandsHelp);
}

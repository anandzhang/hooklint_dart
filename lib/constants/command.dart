/// cli arguments
enum Command {
  /// install pre-commit hook
  install,

  /// execute dart format...
  run,
}

/// Command description
extension CommandExtension on Command {
  /// is the specified command
  bool be(String argument) => name == argument;

  /// description
  String get description {
    switch (this) {
      case Command.install:
        return 'Create git pre-commit hook.';
      case Command.run:
        return 'Execute lint task.';
    }
  }
}

/// commands help
final String commandsHelp = '''
Usage: hooklint [command]
  
Commands:
  ${Command.install.name}: ${Command.install.description}
  ${Command.run.name}: ${Command.run.description}
${Command.run.name} is used by default.
''';

import 'dart:io';
import 'dart:isolate';
import 'package:path/path.dart' as path;

/// install git pre-commit hook
Future<void> install() async {
  // get .git/hooks
  final ProcessResult result =
      Process.runSync('git', ['rev-parse', '--git-dir']);
  if (result.stdout is! String || result.stdout.isEmpty) {
    print('not a git repository');
    return;
  }

  final File preCommitHook =
      File('${(result.stdout as String).trim()}/hooks/pre-commit');
  if (preCommitHook.existsSync()) {
    // backup pre-commit hook
    final File backup = File(
        '${preCommitHook.path}.bak.${DateTime.now().millisecondsSinceEpoch}');
    backup.writeAsStringSync(preCommitHook.readAsStringSync());
  }

  // hook template
  final Uri? packageUri =
      await Isolate.resolvePackageUri(Uri.parse('package:hooklint/'));
  if (packageUri?.path.isEmpty ?? true) {
    print('not found hooklint package');
    return;
  }
  final File preCommitTemplate = File(
      path.normalize(path.join(packageUri!.path, '../templates/pre-commit')));
  // write hook
  preCommitHook.writeAsStringSync(preCommitTemplate.readAsStringSync());

  // executable
  final chmodResult = Process.runSync('chmod', ['+x', preCommitHook.path]);
  stdout.write(chmodResult.stdout);
  stderr.write(chmodResult.stderr);
}

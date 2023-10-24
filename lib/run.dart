import 'dart:io';

import 'package:hooklint/utils/pubspec_util.dart';

/// run lint
Future<void> run() async {
  final ProcessResult result = await Process.run('git', [
    'diff',
    '--name-only',
    '--cached',
    // Added (A), Copied (C), Modified (M), Renamed (R)
    // https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---diff-filterACDMRTUXB82308203
    '--diff-filter=ACMR',
    '--',
    '*.dart',
  ]);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    return;
  }

  if (result.stdout is! String) {
    print('not expected value');
    return;
  }

  final stagedResult = (result.stdout as String).trim();
  if (stagedResult.isEmpty) {
    print('No staged files found.');
    return;
  }

  final List<String> stagedFiles = stagedResult.split('\n');

  // try to fix
  if (PubspecUtil.shared.allowAutomaticFix) {
    await Future.wait(stagedFiles.map((file) => Process.start(
        'dart', ['fix', '--apply', file],
        mode: ProcessStartMode.inheritStdio)));
  }

  // format
  final process = await Process.start('dart', ['format', ...stagedFiles],
      mode: ProcessStartMode.inheritStdio);
  if (await process.exitCode != 0) return;
  // re-add
  await Process.start('git', ['add', ...stagedFiles]);

  // analyze
  final analyzeProcess = await Process.start(
      'dart', ['analyze', ...stagedFiles],
      mode: ProcessStartMode.inheritStdio);
  final analyzeExitCode = await analyzeProcess.exitCode;
  if (analyzeExitCode != 0) {
    print('\nYou can try to use `dart fix` to fix the above issues.');
    print('Commit again after no errors.');
  }

  exit(analyzeExitCode);
}

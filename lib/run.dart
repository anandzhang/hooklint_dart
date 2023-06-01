import 'dart:async';
import 'dart:io';

import 'package:hooklint/logger_util.dart';

/// run lint
Future<void> run() async {
  final ProcessResult result = await Process.run('git', [
    'diff',
    '--name-only',
    '--cached',
    '--diff-filter=ACM',
    '--',
    '*.dart',
  ]);

  if (result.stdout is! String) {
    print('not expected value.');
    return;
  }

  // no files
  if ((result.stdout as String).isEmpty) {
    print('nothing to lint.');
    return;
  }

  final List<String> stagedFiles = (result.stdout as String).trim().split('\n');

  // try to fix
  LoggerUtil.shared.progress('dart fix: ${stagedFiles.length} files');
  // await Future.wait(stagedFiles
  //     .map((file) => Process.start('dart', ['fix', '--apply', file])));
  LoggerUtil.shared.finish();

  // format
  LoggerUtil.shared.progress('dart format');
  await Process.run('dart', ['format', ...stagedFiles]);
  LoggerUtil.shared.finish();

  // re-add
  await Process.run('git', ['add', ...stagedFiles]);

  // analyze
  LoggerUtil.shared.progress('dart analyze');
  final ProcessResult analyzeResult =
      await Process.run('dart', ['analyze', ...stagedFiles]);
  LoggerUtil.shared.finish();
  stdout.write(analyzeResult.stdout);
  exit(analyzeResult.exitCode);
}

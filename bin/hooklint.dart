import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  // Windows 未测试
  if (Platform.isWindows) return;

  // 获取 .git/hooks
  final ProcessResult result =
      Process.runSync('git', ['rev-parse', '--git-dir']);
  if (result.stdout is! String || result.stdout.isEmpty) {
    print('not a git repository');
    return;
  }

  final File preCommitHook =
      File('${(result.stdout as String).trim()}/hooks/pre-commit');
  if (preCommitHook.existsSync()) {
    // 已有 pre-commit hook 先备份
    final File backup = File(
        '${preCommitHook.path}.bak.${DateTime.now().millisecondsSinceEpoch}');
    backup.writeAsStringSync(preCommitHook.readAsStringSync());
  }

  // 获取hook模板
  final Uri? packageUri =
      await Isolate.resolvePackageUri(Uri.parse('package:flutter_git_hooks/'));
  if (packageUri?.path.isEmpty ?? true) {
    print('not found package');
    return;
  }
  final File preCommitTemplate = File(
      path.normalize(path.join(packageUri!.path, '../templates/pre-commit')));
  // 写入hook
  preCommitHook.writeAsStringSync(preCommitTemplate.readAsStringSync());

  // 添加执行权限
  final chmodResult = Process.runSync('chmod', ['+x', preCommitHook.path]);
  stdout.write(chmodResult.stdout);
  stderr.write(chmodResult.stderr);
}

import 'dart:io';

import 'package:yaml/yaml.dart';

/// pubspec.yaml file util
class PubspecUtil {
  static PubspecUtil? _instance;

  /// singleton
  static PubspecUtil get shared {
    _instance ??= PubspecUtil();
    return _instance!;
  }

  /// pubspec.yaml file map
  final YamlMap yaml;

  /// constructor
  PubspecUtil() : yaml = loadYaml(File('pubspec.yaml').readAsStringSync());

  /// has package dependency
  bool get hasDependency {
    final YamlMap? devDependencies = yaml['dev_dependencies'];
    return devDependencies?['hooklint'] != null;
  }

  /// Allow using dart fix
  ///
  /// Default is false
  bool get allowAutomaticFix {
    final YamlMap? config = yaml['hooklint'];
    return config?['autofix'] ?? false;
  }
}

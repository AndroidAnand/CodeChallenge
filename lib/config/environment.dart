import 'package:code_challenge/util/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static bool isProd() {
    return const bool.fromEnvironment('IS_PROD', defaultValue: false);
  }

  static bool get isLocal {
    return dotenv.env['IS_LOCAL'] == 'true';
  }

  static bool isNotProd() {
    return !isProd();
  }

  static String get fileName => "env/env.default";

  static String get apiBaseUrl => Utils.isNotNullEmptyFalseOrZero(const String.fromEnvironment('API_BASE_URL')) ?
  const String.fromEnvironment('API_BASE_URL') : dotenv.env['API_BASE_URL'] ?? 'UNDEFINED';
}
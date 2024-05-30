import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  static bool isNotNullEmptyFalseOrZero(Object? o) => !isNullEmptyFalseOrZero(o);
  static bool isNullEmptyFalseOrZero(Object? o) => o == null || false == o || 0 == o || "" == o;

  static String get apiBaseUrl => Utils.isNotNullEmptyFalseOrZero(const String.fromEnvironment('API_BASE_URL')) ?
  const String.fromEnvironment('API_BASE_URL') : dotenv.env['API_BASE_URL'] ?? 'UNDEFINED';

}
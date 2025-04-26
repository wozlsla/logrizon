/* 
$ flutter run -d chrome --dart-define=ENV=dev --dart-define=API_URL=https://dev.api.com
$ flutter build web --dart-define=IS_WEB=true --dart-define=ENV=prod --dart-define=API_URL=http://logrizon.im/api/v1 
*/
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  /// 실행 환경 체크 : 웹, 앱(iOS/Android) 판별
  static final bool isWeb = const bool.fromEnvironment(
    'IS_WEB',
    defaultValue: false,
  );

  /// Reads the environment type (dev, prod) from 'dart-define'. Defaults to 'dev'.
  static final String env = const String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  /// Loads the correct environment file for local development.
  static Future<void> loadEnv() async {
    /// 모바일/로컬 환경에서만 실행 (.env 읽음)
    if (!isWeb) {
      String envFile = '.env.$env';
      try {
        await dotenv.load(fileName: envFile);
      } catch (e) {
        throw Exception(
          'Failed to load environment file: $envFile. Make sure it exists.',
        );
      }
    }
  }

  /// Retrieves the API URL from 'dart-define' or '.env' file.
  static String get apiUrl {
    /// dart-define으로 전달된 값이 있으면 그 값을 우선적으로 사용
    return const String.fromEnvironment('API_URL', defaultValue: '').isNotEmpty
        ? const String.fromEnvironment('API_URL')
        : dotenv.env['API_URL'] ?? 'https://api.default.com'; // 수정
  }
}

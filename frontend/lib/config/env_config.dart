import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  /// Checks if the app is running on Web
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
    return const String.fromEnvironment('API_URL', defaultValue: '').isNotEmpty
        ? const String.fromEnvironment('API_URL')
        : dotenv.env['API_URL'] ?? 'https://api.default.com';
  }
}

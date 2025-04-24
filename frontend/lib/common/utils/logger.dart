import 'package:logger/logger.dart';

// 전역 인스턴스 선언
final logger = Logger(
  // filter: null,
  // output: null,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8, // Number of method calls if stacktrace is provided
    lineLength: 40, // Width of the output
    colors: false,
    // dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

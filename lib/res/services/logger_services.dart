import 'package:logger/logger.dart';

/// Logger Service for handling application logging
/// Provides colorful and formatted logging throughout the app
class LoggerService {
  static Logger? _logger;

  /// Initialize the logger service
  static void init() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat:
        DateTimeFormat.onlyTimeAndSinceStart, // Timestamp format
      ),
    );
  }

  /// Log debug messages
  /// Use for detailed information during development
  static void debug(String message) {
    _logger?.d(message);
  }

  /// Log info messages
  /// Use for general information about app flow
  static void info(String message) {
    _logger?.i(message);
  }

  /// Log warning messages
  /// Use for potentially harmful situations
  static void warning(String message) {
    _logger?.w(message);
  }

  /// Log error messages
  /// Use for error events that might still allow the app to continue
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log verbose messages
  /// Use for the most detailed logging
  static void verbose(String message) {
    _logger?.t(message);
  }

  /// Log wtf (What a Terrible Failure) messages
  /// Use for situations that should never happen
  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger?.f(message, error: error, stackTrace: stackTrace);
  }
}

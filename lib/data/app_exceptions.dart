/// Base exception class for all application exceptions
///
/// All custom exceptions should extend this class
/// to provide consistent error handling throughout the app.
class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }

  /// Get the error message
  String get message => _message ?? '';

  /// Get the error prefix
  String get prefix => _prefix ?? '';
}

/// Exception thrown when no internet connection is available
class InternetException extends AppException {
  InternetException([String? message]) : super(message, 'No internet: ');
}

/// Exception thrown when request times out
class RequestTimeout extends AppException {
  RequestTimeout([String? message]) : super(message, 'Request timeout: ');
}

/// Exception thrown when server returns 5xx error
class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Internal server error: ');
}

/// Exception thrown when URL is invalid
class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message, 'Invalid URL: ');
}

/// Exception thrown when unable to fetch data
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error while communicating: ');
}

/// Exception thrown when request is malformed (400)
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Bad request: ');
}

/// Exception thrown when user is not authorized (401, 403)
class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized: ');
}

/// Exception thrown when resource is not found (404)
class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Not found: ');
}

/// Exception thrown when HTTP client errors occur
class HttpException extends AppException {
  HttpException([String? message]) : super(message, 'HTTP error: ');
}

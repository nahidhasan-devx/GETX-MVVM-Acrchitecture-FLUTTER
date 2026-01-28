import 'package:getx_mvvm/data/response/status.dart';

/// Generic API response wrapper for handling different states
///
/// This class provides a type-safe way to handle API responses
/// with different states: loading, completed, and error.
///
/// Usage:
/// ```dart
/// var response = ApiResponse<User>.loading();
///
/// // After API call
/// response = ApiResponse<User>.completed(user);
///
/// // On error
/// response = ApiResponse<User>.error('Failed to load data');
/// ```
class ApiResponse<T> {
  /// The current status of the API response
  Status? status;

  /// The response data (if status is COMPLETED)
  T? data;

  /// Error message (if status is ERROR)
  String? message;

  /// Constructor for creating a response with all parameters
  ApiResponse(this.status, this.data, this.message);

  /// Creates a loading state response
  ApiResponse.loading() : status = Status.LOADING;

  /// Creates a completed state response with data
  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  /// Creates an error state response with a message
  ApiResponse.error(this.message) : status = Status.ERROR;

  /// Returns true if the status is LOADING
  bool get isLoading => status == Status.LOADING;

  /// Returns true if the status is COMPLETED
  bool get isCompleted => status == Status.COMPLETED;

  /// Returns true if the status is ERROR
  bool get isError => status == Status.ERROR;

  @override
  String toString() {
    return 'ApiResponse { status: $status, data: $data, message: $message }';
  }

  /// Equality operator for comparing ApiResponse instances
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiResponse<T> &&
        other.status == status &&
        other.data == data &&
        other.message == message;
  }

  /// Hash code for using ApiResponse in collections
  @override
  int get hashCode => status.hashCode ^ data.hashCode ^ message.hashCode;
}

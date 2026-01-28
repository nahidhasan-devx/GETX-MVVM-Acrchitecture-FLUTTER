/// Enum representing the status of an API response
///
/// Used in conjunction with [ApiResponse] to track
/// the state of network requests.
enum Status {
  /// Request is in progress
  LOADING,

  /// Request completed successfully
  COMPLETED,

  /// Request failed with an error
  ERROR,
}

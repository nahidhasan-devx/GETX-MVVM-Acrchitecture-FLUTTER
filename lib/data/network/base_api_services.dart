/// Abstract base class for API services
///
/// This class defines the contract for all API operations.
/// Implementations should handle network requests, error handling,
/// and response parsing.
abstract class BaseApiServices {
  /// Performs a GET request to the specified URL
  ///
  /// [url] The endpoint URL to request data from
  /// Returns the response data as dynamic
  /// Throws [AppException] on network or server errors
  Future<dynamic> getGetApiResponse(String url);

  /// Performs a POST request to the specified URL
  ///
  /// [data] The request body to send
  /// [url] The endpoint URL to send data to
  /// Returns the response data as dynamic
  /// Throws [AppException] on network or server errors
  Future<dynamic> getPostApiResponse(dynamic data, String url);

  /// Performs a PUT request to the specified URL
  ///
  /// [data] The request body to send
  /// [url] The endpoint URL to update data at
  /// Returns the response data as dynamic
  /// Throws [AppException] on network or server errors
  Future<dynamic> getPutApiResponse(dynamic data, String url);

  /// Performs a DELETE request to the specified URL
  ///
  /// [url] The endpoint URL to delete data from
  /// Returns the response data as dynamic
  /// Throws [AppException] on network or server errors
  Future<dynamic> getDeleteApiResponse(String url);
}

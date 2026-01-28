/// Centralized API endpoint management
///
/// This class contains all API endpoints used throughout the application.
/// It's recommended to use environment variables for different environments
/// (development, staging, production).
class AppUrl {
  /// Base URL for all API requests
  ///
  /// Change this based on your environment:
  /// - Development: Use local or staging server
  /// - Production: Use production server URL
  static const String baseUrl = 'https://reqres.in';

  /// Authentication endpoints
  ///
  /// Login endpoint for user authentication
  /// Returns: { token: String }
  static const String loginUrl = '$baseUrl/api/login';

  /// User endpoints
  ///
  /// Get list of users
  /// Returns: List of user objects
  /// Note: This is a webhook URL for testing purposes
  /// Replace with actual API endpoint in production
  static const String userListApi = 'https://webhook.site/e306b6c5-7cd7-4d01-b896-aee44f1ae684';

  /// Example additional endpoints (commented out for template)
  // static const String userProfile = '$baseUrl/api/users/{id}';
  // static const String updateUser = '$baseUrl/api/users/{id}';
  // static const String deleteUser = '$baseUrl/api/users/{id}';
  // static const String createUser = '$baseUrl/api/users';
}

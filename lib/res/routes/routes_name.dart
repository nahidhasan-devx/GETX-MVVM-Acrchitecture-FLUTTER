/// Centralized route name constants
///
/// This class contains all route names used throughout the application.
/// Using constants instead of strings helps prevent typos and makes
/// refactoring easier with IDE support.
class RoutesName {
  /// Splash Screen Route
  ///
  /// The initial screen shown when the app launches
  /// Displays app branding and performs initial setup
  static const String splashScreen = '/splash_screen';

  /// Login Screen Route
  ///
  /// User authentication screen
  /// Users can log in with email and password
  static const String loginScreen = '/login_screen';

  /// Home Screen Route
  ///
  /// Main dashboard screen shown after successful login
  /// Contains primary app functionality
  static const String homeScreen = '/home_screen';

  /// Example additional routes (commented out for template)
  // static const String profileScreen = '/profile_screen';
  // static const String settingsScreen = '/settings_screen';
  // static const String aboutScreen = '/about_screen';
}

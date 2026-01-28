import 'package:get/get.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/screen/home/home_screen.dart';
import 'package:getx_mvvm/screen/login/login_screen.dart';

import '../../screen/splash_screen.dart';

/// Centralized route configuration for the application
///
/// This class defines all application routes using GetX navigation.
/// Each route includes:
/// - A unique name defined in [RoutesName]
/// - The widget to display
/// - Transition animations
/// - Optional middlewares and bindings
class AppRoutes {
  /// Returns a list of all application routes
  ///
  /// This method is called in [MyApp] to configure
  /// the GetX navigation system.
  ///
  /// Add new routes here as your application grows.
  static appRoutes() => [
    /// Splash Screen
    ///
    /// Shown immediately when app launches
    /// Displays logo and performs initialization
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),

    /// Login Screen
    ///
    /// User authentication screen
    /// Users enter credentials to login
    GetPage(
      name: RoutesName.loginScreen,
      page: () => const LoginScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),

    /// Home Screen
    ///
    /// Main dashboard after successful login
    /// Contains primary app features
    GetPage(
      name: RoutesName.homeScreen,
      page: () => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRight,
    ),

    /// Example additional routes (commented out for template)
    // GetPage(
    //   name: RoutesName.profileScreen,
    //   page: () => const ProfileScreen(),
    //   transition: Transition.rightToLeft,
    //   middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: RoutesName.settingsScreen,
    //   page: () => const SettingsScreen(),
    //   transition: Transition.fadeIn,
    // ),
  ];
}

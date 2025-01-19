import 'package:get/get.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/screen/home/home_screen.dart';
import 'package:getx_mvvm/screen/login/login_screen.dart';
import '../../screen/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RoutesName.splashScreen,
          page: () => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRight,
        ),
        GetPage(
          name: RoutesName.loginScreen,
          page: () => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRight,
        ),

        GetPage(
          name: RoutesName.homeScreen,
          page: () => const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRight,
        ),
      ];
}

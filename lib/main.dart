import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/getx_localization/languages.dart';
import 'package:getx_mvvm/res/routes/routes.dart';
import 'package:getx_mvvm/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Languages(),
      locale: Locale('en','US'),
      fallbackLocale: Locale('en','US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}


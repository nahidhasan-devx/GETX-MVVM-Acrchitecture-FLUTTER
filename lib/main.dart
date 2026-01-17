import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/getx_localization/languages.dart';
import 'package:getx_mvvm/res/routes/routes.dart';
import 'package:getx_mvvm/res/services/local_storage_services.dart';
import 'package:getx_mvvm/res/services/logger_services.dart';
import 'package:getx_mvvm/screen/splash_screen.dart';

import 'my_app.dart';

Future<void> main() async {
  await _initializeServices();
  runApp(const MyApp());
}


Future<void> _initializeServices() async {
  // Initialize logger service
  LoggerService.init();
  LoggerService.info('🚀 Application starting...');

  // Initialize local storage service
  await LocalStorageService.init();
  LoggerService.info('💾 Local storage initialized');

  // Initialize HTTP service
  LoggerService.info('🌐 HTTP service initialized');

  LoggerService.info('✅ All services initialized successfully');
}



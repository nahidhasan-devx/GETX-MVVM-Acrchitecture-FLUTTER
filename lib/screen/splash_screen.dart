import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/assets/image_assets.dart';
import 'package:getx_mvvm/res/components/internet_exception_widget.dart';
import 'package:getx_mvvm/view_model/services/splash_services.dart';

import '../res/components/general_exception_widget.dart';
import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices=SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    splashServices.isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Utils.toastMessage('This is a toast message'),
      ),
      appBar: AppBar(
        title: Text('email_hint'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage(ImageAssets.splashScreen),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  InternetExceptionWidget(
                    onPress: () {},
                  ),
                );
              },
              child: const Text('Goto InternetException page'),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  GeneralExceptionWidget(
                    onPress: () {},
                  ),
                );
              },
              child: const Text('Goto GeneralException page'),
            ),
          ],
        ),
      ),
    );
  }
}

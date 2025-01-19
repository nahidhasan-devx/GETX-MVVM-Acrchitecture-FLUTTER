import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/components/round_button.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_model/controller/login/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginViewModel());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('login'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: loginController.emailController.value,
                    focusNode: loginController.emailFocusNode.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('Email', 'Enter Email');
                      }
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        loginController.emailFocusNode.value,
                        loginController.passwordFocusNode.value,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'email_hint'.tr,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: loginController.passwordController.value,
                    focusNode: loginController.passwordFocusNode.value,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('Password', 'Enter Password');
                      }
                    },
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      hintText: 'password_hint'.tr,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(
              () => RoundButton(
                title: "login".tr,
                isLoading: loginController.isLoading.value,
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    loginController.loginApi();
                  }
                },
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

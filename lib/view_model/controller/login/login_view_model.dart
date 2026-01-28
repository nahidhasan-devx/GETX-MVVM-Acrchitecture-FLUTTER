import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/login_response_model.dart';
import 'package:getx_mvvm/repository/login_repository/login_repository.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';
import 'package:getx_mvvm/view_model/controller/user_preference/user_preferences_view_model.dart';

/// Login ViewModel
///
/// Handles login logic including:
/// - Form validation
/// - API communication
/// - User session management
/// - Navigation
///
/// Follows MVVM pattern where this ViewModel bridges
/// between the View (LoginScreen) and Model (Repository).
class LoginViewModel extends GetxController {
  /// Repository instance for login API calls
  final _api = LoginRepository();

  /// User preferences for managing user session
  final userPreferences = UserPreferences();

  /// Email text field controller
  final emailController = TextEditingController().obs;

  /// Password text field controller
  final passwordController = TextEditingController().obs;

  /// Email field focus node
  final emailFocusNode = FocusNode().obs;

  /// Password field focus node
  final passwordFocusNode = FocusNode().obs;

  /// Loading state for the login button
  RxBool isLoading = false.obs;

  /// Validate and submit login form
  ///
  /// This method:
  /// 1. Validates input fields
  /// 2. Shows loading state
  /// 3. Calls login API
  /// 4. Saves user session
  /// 5. Navigates to home screen
  ///
  /// Shows error messages using [Utils.snackBar]
  void loginApi() {
    // Validate email
    if (emailController.value.text.isEmpty) {
      Utils.snackBar('Error', 'Please enter email');
      return;
    }

    // Validate password
    if (passwordController.value.text.isEmpty) {
      Utils.snackBar('Error', 'Please enter password');
      return;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.value.text)) {
      Utils.snackBar('Error', 'Please enter a valid email');
      return;
    }

    // Start loading
    isLoading.value = true;

    // Prepare login data
    Map data = {
      'email': emailController.value.text.trim(),
      'password': passwordController.value.text,
    };

    // Call login API
    _api
        .loginApi(data)
        .then((value) {
          isLoading.value = false;

          // Check if user not found
          if (value['error'] == 'user not found') {
            Utils.snackBar('Login Failed', value['error']);
          } else {
            // Success - save user session
            LoginResponseModel loginResponseModel = LoginResponseModel(
              token: value['token'],
              isLogin: true,
            );

            // Save user preferences
            userPreferences
                .saveUser(loginResponseModel)
                .then((value) {
                  Utils.snackBar('Success', 'Login successful');

                  // Navigate to home screen
                  Get.toNamed(RoutesName.homeScreen);
                })
                .onError((error, stackTrace) {
                  Utils.snackBar('Error', 'Failed to save user session');
                });
          }
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          Utils.snackBar('Login Failed', error.toString());
        });
  }

  /// Clear all text fields
  void clearFields() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    emailController.value.dispose();
    passwordController.value.dispose();
    emailFocusNode.value.dispose();
    passwordFocusNode.value.dispose();
    super.onClose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/colors/app_colors.dart';

/// Utility class for common application functions
///
/// Provides helper methods for:
/// - Focus management
/// - Toast notifications
/// - SnackBar notifications
/// - Input validation
class Utils {
  /// Change focus from one text field to another
  ///
  /// [context] BuildContext for accessing focus scope
  /// [current] Current focus node to unfocus
  /// [next] Next focus node to receive focus
  ///
  /// Commonly used in text field onFieldSubmitted callback
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  /// Show a toast notification
  ///
  /// [message] The message to display
  ///
  /// Toasts are short-lived notifications that appear
  /// briefly at the bottom of the screen.
  static void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.blackColor,
      textColor: AppColor.whiteColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }

  /// Show a snackbar notification
  ///
  /// [title] The title/header of the snackbar
  /// [message] The message/description to display
  ///
  /// Snackbars are more prominent than toasts and can
  /// include actions and longer text.
  static void snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.blackColor,
      colorText: AppColor.whiteColor,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// Validate email format
  ///
  /// [email] The email string to validate
  /// Returns true if email format is valid, false otherwise
  static bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  /// Validate phone number format
  ///
  /// [phone] The phone number string to validate
  /// Returns true if phone format is valid, false otherwise
  static bool isValidPhone(String phone) {
    return GetUtils.isPhoneNumber(phone);
  }

  /// Validate URL format
  ///
  /// [url] The URL string to validate
  /// Returns true if URL format is valid, false otherwise
  static bool isValidUrl(String url) {
    return GetUtils.isURL(url);
  }

  /// Check if string is null or empty
  ///
  /// [value] The string to check
  /// Returns true if string is null or empty, false otherwise
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// Capitalize first letter of string
  ///
  /// [text] The text to capitalize
  /// Returns text with first letter capitalized
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Hide keyboard
  ///
  /// Hides the on-screen keyboard by unfocusing any focused widget
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

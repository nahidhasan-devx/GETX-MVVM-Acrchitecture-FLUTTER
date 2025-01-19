import 'package:get/get.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'internet_exception':"We're unable to show results.\nPlease check your data\nconnection.",
      'general_exception': "We're unable to process your request.\n Please try again",
      'login': 'Log In',
      'email_hint': 'Email',
      'password_hint': 'Password',
    },
    'ur_PK':{
      'email_hint': 'ای میل درج کریں'
    }
  };
}

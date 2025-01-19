import 'package:shared_preferences/shared_preferences.dart';

class LoginResponseModel {
  String? token;
  bool? isLogin;

  LoginResponseModel({this.token,this.isLogin});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin=json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['isLogin']=this.isLogin;
    return data;
  }
}

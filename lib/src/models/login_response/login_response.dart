
import 'package:bank_account_kata_flutter/src/models/base/base.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class LoginResponse extends BaseModel<LoginResponse>{
  String accessToken;
  String refreshToken;
  User user;

  LoginResponse({this.accessToken, this.refreshToken, this.user});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['user'] = this.user.toJson();
    return data;
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        user:  json['user'] != null ? new User.fromJson(json['user']) : null
    );
  }
}
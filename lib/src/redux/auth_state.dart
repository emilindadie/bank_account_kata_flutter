
import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class AuthState {
  bool isAuthenticated;
  User user;
  String accessToken;

  AuthState({this.isAuthenticated = false, this.user, this.accessToken});
}

import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class AuthAction {
  String type;
  User user;
  String access_token;

  AuthAction({this.type, this.user, this.access_token});
  AuthAction.create(this.type, this.user, this.access_token);
}

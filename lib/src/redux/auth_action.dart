
import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class AuthAction {
  String type;
  User user;
  String accessToken;

  AuthAction({this.type, this.user, this.accessToken});
  AuthAction.create(this.type, this.user, this.accessToken);
}

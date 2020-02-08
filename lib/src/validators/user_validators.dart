import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class UserValidators {

  bool validEmailType(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validSignUpUserProperty(User user){
    return user.id.toString().isNotEmpty && user.name.isNotEmpty && user.email.isNotEmpty && user.password.isNotEmpty && user.address.isNotEmpty && validEmailType(user.email);
  }

  bool validSignInUserProperty(String email, String password){
    return email.isNotEmpty && validEmailType(email) && password.isNotEmpty;
  }
}

import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';

class SignInBloc implements BlocBase {

  BehaviorSubject<String> _emailController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>.seeded("");

  Stream<String> get email => _emailController.stream;
  Stream<String> get password => _passwordController.stream;


  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  void dispose() {
    _emailController.close();
    _passwordController.close();
  }

  Future<LoginResponse> signInUser() async {
    return UserRepository().signInUser(User(email : _emailController.value, password: _passwordController.value));
  }
}
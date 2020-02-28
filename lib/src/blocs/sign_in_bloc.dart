
import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:bank_account_kata_flutter/src/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';

class SignInBloc with LoginValidators implements BlocBase {

  UserRepository repository;

  SignInBloc({this.repository});

  BehaviorSubject<String> _emailController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<bool> _submitCheckController = BehaviorSubject<bool>.seeded(true);

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordValidator);
  Stream<bool> get submitCheck => _submitCheckController.stream.transform(buttonValidator(_emailController, _passwordController));

  Function(String) get updateEmail {
    _submitCheckController.sink.add(true);
    return _emailController.sink.add;
  }

  Function(String) get updatePassword {
    _submitCheckController.sink.add(true);
    return _passwordController.sink.add;
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
  }

  Future<ApiResponse<LoginResponse>> signInUser() async {
      return repository.signInUser(User(email : _emailController.value, password: _passwordController.value));
  }
}
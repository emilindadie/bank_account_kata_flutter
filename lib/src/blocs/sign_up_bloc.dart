import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class SignUpBloc implements BlocBase {

  BehaviorSubject<String> _nameController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _emailController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _addressController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>.seeded("");

  Stream<String> get name => _nameController.stream;
  Stream<String> get email => _emailController.stream;
  Stream<String> get address => _addressController.stream;
  Stream<String> get password => _passwordController.stream;


  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  void dispose() {
    _nameController.close();
    _emailController.close();
    _addressController.close();
    _passwordController.close();
  }


  Future<User> signInUser() async {
    return UserRepository().signUpUser(User(name: _nameController.value, email : _emailController.value, address: _addressController.value, password: _passwordController.value));
  }
}
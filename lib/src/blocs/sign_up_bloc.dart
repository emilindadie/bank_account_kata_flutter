import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:bank_account_kata_flutter/src/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class SignUpBloc with SignUpValidators implements BlocBase {


  UserRepository repository;

  SignUpBloc({this.repository});

  BehaviorSubject<String> _nameController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _emailController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _addressController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<String> _passwordController = BehaviorSubject<String>.seeded("");
  BehaviorSubject<bool> _submitCheckController = BehaviorSubject<bool>.seeded(true);

  Stream<String> get name => _nameController.stream.transform(nameValidator);
  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get address => _addressController.stream.transform(addressValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordValidator);
  Stream<bool> get submitCheck => _submitCheckController.stream.transform(buttonValidator(_nameController, _emailController, _addressController, _passwordController));

  Function(String) get updateName {
    _submitCheckController.sink.add(true);
    return _nameController.sink.add;
  }

  Function(String) get updateEmail {
    _submitCheckController.sink.add(true);
    return _emailController.sink.add;
  }

  Function(String) get updateAddress {
    _submitCheckController.sink.add(true);
    return _addressController.sink.add;
  }

  Function(String) get updatePassword {
    _submitCheckController.sink.add(true);
    return _passwordController.sink.add;
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _addressController.close();
    _passwordController.close();
  }

  Future<User> signUpUser() async {
    return repository.signUpUser(User(name: _nameController.value, email : _emailController.value, address: _addressController.value, password: _passwordController.value));
  }
}
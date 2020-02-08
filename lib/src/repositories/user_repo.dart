import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/validators/user_validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {

  UserValidators validators = UserValidators();

  Future<User> signUpUser(User user) async {
    if(!validators.validSignUpUserProperty(user)){
      throw Exception('All field is requiered!');
    }

    final response = await http.post(new Uri.http("localhost:3001", "/user"), body: user.signUpDataToJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<LoginResponse> signInUser(User user) async {
    if(!validators.validSignInUserProperty(user.email, user.password)){
      throw Exception('Email and password is required');
    }
    if(!validators.validEmailType(user.email)){
      throw Exception('Incorrect email');
    }

    final response = await http.post(new Uri.http("localhost:3001", "/user/login"), body: user.signInDataToJson());
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return LoginResponse.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to log user');
    }
  }
}
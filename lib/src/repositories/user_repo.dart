
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/validators/user_validators.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

class UserRepository {
  var client = Client();

  UserValidators validators = UserValidators();

  Future<User> signUpUser(User user) async {
    print(user.toJson());
    if(!validators.validSignUpUserProperty(user)){
      throw Exception('All field is requiered!');
    }

    final response = await client.post(new Uri.http("localhost:3001", "/users"), body: user.signUpDataToJson());
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['data']);
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

    final response = await client.post(new Uri.http("localhost:3001", "/users/login"), body: user.signInDataToJson());
    if (response.statusCode == 200) {
      return LoginResponse().fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Password or email is wrong');
    }
  }
}
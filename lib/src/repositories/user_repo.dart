import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {

  Future<User> signUpUser(User user) async {

    if(!user.validSignUpUserProperty()){
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
    if(!user.validSignInUserProperty()){
      throw Exception('Email and password is required');
    }
    if(!user.validEmailType()){
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
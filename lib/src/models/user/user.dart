
import 'package:bank_account_kata_flutter/src/models/base/base.dart';

class User extends BaseModel<User>{
  int id;
  String name;
  String email;
  String password;
  String address;

  User({this.id, this.name, this.email, this.password, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
  }


  @override
  User fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    return data;
  }

  Map<String, dynamic> signUpDataToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    return data;
  }

  Map<String, dynamic> signInDataToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
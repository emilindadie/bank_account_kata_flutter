

import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/user/user.dart';

class CreateAccount {
  String name;
  User user;

  CreateAccount({this.name, this.user});

  CreateAccount.create(this.name, this.user);

  CreateAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.user != null) {
      data['user'] =  jsonEncode(this.user.toJson());
    }
    return data;
  }
}
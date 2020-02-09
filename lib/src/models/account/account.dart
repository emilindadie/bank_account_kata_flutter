

import 'package:bank_account_kata_flutter/src/models/base/base.dart';

class Account extends BaseModel<Account>{
  int id;
  String name;
  int solde;

  Account({this.id, this.name, this.solde});

  @override
  Account fromJson(Map<String, dynamic> json) {
    return Account(id: json['id'], name: json['name'], solde: json['solde'] );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['solde'] = this.solde;
    return data;
  }
}
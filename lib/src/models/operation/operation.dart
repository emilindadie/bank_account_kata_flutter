import 'dart:convert';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/base/base.dart';

class Operation extends BaseModel<Operation>{
  int id;
  String type;
  int amount;
  DateTime date;
  Account account;

  Operation({this.id, this.type, this.amount, this.date, this.account});

  @override
  Operation fromJson(Map<String, dynamic> json) {
    return Operation(id: json['id'], type: json['type'], amount: json['amount'], date: this.date);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.account != null) {
      data['account'] =  jsonEncode(this.account.toJson());
    }
    data['date'] = this.date.toIso8601String();
    return data;
  }
}

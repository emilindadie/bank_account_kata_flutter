import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/account/account_create.dart';
import 'package:bank_account_kata_flutter/src/models/api/api_error.dart';
import 'dart:convert';
import 'package:http/http.dart';

class AccountRepository {
  var client = Client();

  Future<List<Account>> loadAccounts(int userId, String accessToken) async {

    final response = await client.get(new Uri.http("localhost:3001", "/accounts", {'userId': userId.toString()}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 200 && jsonDecode(response.body)['data'] != null) {
      List<dynamic> jsonAccountList = jsonDecode(response.body)["data"];
      List<Account> accounts = new List<Account>();
      accounts = jsonAccountList.map((i) => Account().fromJson(i)).toList();
      return accounts;
    }
    else if(response.statusCode == 200 && jsonDecode(response.body)['error'] != null) {
      throw Exception(ApiError().fromJson(jsonDecode(response.body)['error']).message);
    }
    else {
      throw Exception('Failed to create accounts');
    }
  }

  Future<Account> createAccount(CreateAccount createAccount , String accessToken) async {
    final response = await client.post(new Uri.http("localhost:3001", "/accounts"), body: createAccount.toJson(),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 200 && jsonDecode(response.body)['data'] != null) {
      return Account().fromJson(jsonDecode(response.body)['data']);
    }
    else if(response.statusCode == 200 && jsonDecode(response.body)['error'] != null) {
      throw Exception(ApiError().fromJson(jsonDecode(response.body)['error']).message);
    }
    else {
      throw Exception('Failed to create accounts');
    }
  }

}
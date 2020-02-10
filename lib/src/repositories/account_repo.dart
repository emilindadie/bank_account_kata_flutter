import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/account/account_create.dart';
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

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<dynamic> jsonAccountList = jsonDecode(response.body)["data"];
      List<Account> accounts = new List<Account>();
      accounts = jsonAccountList.map((i) => Account().fromJson(i)).toList();
      return accounts;
    } else {
      throw Exception('Failed to get accounts');
    }
  }

  Future<Account> createAccount(CreateAccount createAccount , String accessToken) async {
    print(createAccount.toJson());

    final response = await client.post(new Uri.http("localhost:3001", "/accounts"), body: createAccount.toJson(),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Account().fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to create accounts');
    }
  }

}
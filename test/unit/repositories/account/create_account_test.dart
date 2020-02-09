import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/account/account_create.dart';
import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/account_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group("Account repository", () {
    test("Should signIn user",  () async {
      // Arrange
      AccountRepository repo = AccountRepository();

      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      final mockResponse = ApiResponse<Account>(data: Account(name: "Compte A", id: 1, solde: 0));

      repo.client = MockClient((request) async {
        return Response(jsonEncode(mockResponse.toJson()), 200);
      });

      // Act
      final output = await repo.createAccount(CreateAccount.create("Compte A", user), "token");

      // Assert
      expect(output.name, equals('Compte A'));
    });
  });
}
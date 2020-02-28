import 'dart:convert';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation_create.dart';
import 'package:bank_account_kata_flutter/src/repositories/operation_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group("Operation repository", () {
    test("Should create operation",  () async {
      // Arrange
      OperationRepository repo = OperationRepository();

      Account account = Account(name: "Compte A", id: 1, solde: 0);
      final mockResponse = ApiResponse<Operation>(data: Operation(id: 1, type: 'Deposit', account: account, amount: 400, date: new DateTime.now()));

      repo.client = MockClient((request) async {
        return Response(jsonEncode(mockResponse.toJson()), 200);
      });

      // Act
      final output = await repo.createOperation(CreateOperation.create(1, 400), "token");

      // Assert
      expect(output.type, equals('Deposit'));
    });
  });
}
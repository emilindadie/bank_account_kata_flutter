import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/account/account_create.dart';
import 'package:bank_account_kata_flutter/src/models/api/api_error.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation.dart';
import 'package:bank_account_kata_flutter/src/models/operation/operation_create.dart';
import 'dart:convert';
import 'package:http/http.dart';

class OperationRepository {
  var client = Client();

  Future<Operation> createOperation(CreateOperation createOperation , String accessToken) async {
    final response = await client.post(new Uri.http("localhost:3001", "/operations"), body: createOperation.toJson(),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 200 && jsonDecode(response.body)['data'] != null) {
      return Operation().fromJson(jsonDecode(response.body)['data']);
    }
    else if(response.statusCode == 200 && jsonDecode(response.body)['error'] != null) {
      throw Exception(ApiError().fromJson(jsonDecode(response.body)['error']).message);
    }
    else {
      throw Exception('Failed to create operation');
    }
  }
}
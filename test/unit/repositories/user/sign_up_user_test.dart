
import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main() {
  group("User repository : signUp user", () {
    test("Should signUp user",  () async {
      // Arrange
      UserRepository repo = UserRepository();
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      final mockResponse = new ApiResponse<User>(data: user);

      repo.client = MockClient((request) async {
        return Response(jsonEncode(mockResponse.toJson()), 200);
      });

      // Act
      final output = await repo.signUpUser(user);

      // Assert
      expect(output.data.email, equals('dadie.emilin@gmail.com'));
    });
  });
}
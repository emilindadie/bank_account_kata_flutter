
import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group("User repository : signIn user", () {

    test("Should signIn user",  () async {
      // Arrange
      final UserRepository repo = UserRepository();
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      final mockResponse = ApiResponse<LoginResponse>(data: LoginResponse(accessToken: 'toto', refreshToken: '', user: User(id: 1)));

      repo.client = MockClient((request) async {
        return Response(jsonEncode(mockResponse.toJson()), 200);
      });

      // Act
      final output = await repo.signInUser(user);

      // Assert
      expect(output.data.accessToken, equals('toto'));
    });
  });
}
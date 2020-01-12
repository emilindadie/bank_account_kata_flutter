
import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../mock/http/http.dart';

void main() {
  group("User repository : signIn user", () {
    test("Should signIn user",  () async {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      var httpMock = MockHttpClient();
      var mockResponse = LoginResponse(accessToken: 'toto', refreshToken: '', user: User(id: 1));
      when(httpMock.post(new Uri.http("localhost:3001", "/user/login"), body: user.signInDataToJson())).thenAnswer((_) async => http.Response(jsonEncode(mockResponse.toJson()), 200));

      // Act
      var output = await httpMock.post(new Uri.http("localhost:3001", "/user/login"), body: user.signInDataToJson());

      // Assert
      expect(LoginResponse.fromJson(jsonDecode(output.body)).accessToken, equals('toto'));
    });
  });
}
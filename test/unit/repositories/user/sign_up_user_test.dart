
import 'dart:convert';

import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../mock/http/http.dart';


void main() {
  group("User repository : signUp user", () {
    test("Should signUp user",  () async {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      var httpMock = MockHttpClient();
      var mockResponse = user;
      when(httpMock.post(new Uri.http("localhost:3001", "/user"), body: user.signInDataToJson())).thenAnswer((_) async => http.Response(jsonEncode(mockResponse.toJson()), 200));

      // Act
      var output = await httpMock.post(new Uri.http("localhost:3001", "/user"), body: user.signInDataToJson());

      // Assert
      expect(User.fromJson(jsonDecode(output.body)).email, equals('dadie.emilin@gmail.com'));
    });
  });
}
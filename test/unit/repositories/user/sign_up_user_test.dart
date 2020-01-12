
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/user.dart';

void main() {
  group("User repository : signUp user", () {
    test("Should signUp user",  () async {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      MockUserRepository repositoryMock = MockUserRepository();
      var mockResponse = user;
      when(repositoryMock.singUpUser(user)).thenAnswer((_) => Future.value(mockResponse));

      // Act
      User output = await repositoryMock.singUpUser(user);

      // Assert
      expect(output.id, isNotNull);
    });
  });
}

import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mock/user.dart';

void main() {
  group("User repository : signIn user", () {
    test("Should signIn user",  () async {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      var repositoryMock = MockUserRepository();
      var mockResponse = LoginResponse(accessToken: '', refreshToken: '', user: User(id: 1));
      when(repositoryMock.signInUser(user)).thenAnswer((_) => Future.value(mockResponse));

      // Act
      LoginResponse output = await repositoryMock.signInUser(user);

      // Assert
      expect(output.user.id, isNotNull);
    });
  });
}
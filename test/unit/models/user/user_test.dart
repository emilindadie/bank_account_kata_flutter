
import 'package:bank_account_kata_flutter/src/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("User model : methodes", () {
    test("Should valid email type ", () {
      // Arrange
      User user = User();
      user.email = 'dadie.emilin@gmail.com';

      // Act
      bool output = user.validEmailType();

      // Assert
      expect(output, equals(true));
    });

    test("Should valid singUp user property", () {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      // Act
      bool output = user.validSignUpUserProperty();

      // Assert
      expect(output, equals(true));
    });

    test("Should valid signIn user property", () {
      // Arrange
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      // Act
      bool output = user.validSignInUserProperty();

      // Assert
      expect(output, equals(true));
    });
  });
}
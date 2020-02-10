
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/validators/user_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("User validator : methodes", () {
    UserValidators validator = new UserValidators();

    test("Should valid email type ", () {
      // Arrange
      User user = User();
      user.email = 'dadie.emilin@gmail.com';

      // Act
      bool output = validator.validEmailType(user.email);

      // Assert
      expect(output, equals(true));
    });

    test("Should valid singUp user property", () {
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      bool output = validator.validSignUpUserProperty(user);

      expect(output, equals(true));
    });

    test("Should valid signIn user property", () {
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      bool output = validator.validSignInUserProperty(user.email, user.password);

      expect(output, equals(true));
    });
  });
}
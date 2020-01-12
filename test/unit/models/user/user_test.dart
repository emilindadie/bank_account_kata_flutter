
import 'package:bank_account_kata_flutter/src/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("User model : methodes", () {
    var user = User();
    test("Should valid email type ", () {
      // Arrange
      var inputEmail = 'dadie.emilin@gmail.com';

      // Act
      var output = user.validEmailType(inputEmail);

      // Assert
      expect(output, equals(true));
    });
  });
}
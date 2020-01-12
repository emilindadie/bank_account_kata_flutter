
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/repositories/user.dart';


void main() {

  group("SignIn bloc", () {

    test("test update name", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputName = "Emilin";

      // Act
      mockBloc.changeName(inputName);

      mockBloc.name.listen((onData){
        // Assert
        expect(onData, equals("Emilin"));
      });
    });


    test("test update email", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputEmail = "dadie.emilin@gmail.com";

      // Act
      mockBloc.changeEmail(inputEmail);

      mockBloc.email.listen((onData){
        // Assert
        expect(onData, equals("dadie.emilin@gmail.com"));
      });
    });

    test("test update address", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputPassword = "14 rue de Mulhouse";

      // Act
      mockBloc.changeAddress(inputPassword);

      mockBloc.address.listen((onData){
        // Assert
        expect(onData, equals("14 rue de Mulhouse"));
      });
    });

    test("test update password", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputPassword = "azerty";

      // Act
      mockBloc.changePassword(inputPassword);

      mockBloc.password.listen((onData){
        // Assert
        expect(onData, equals("azerty"));
      });
    });


    test("test signUp user", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      String inputName = 'Emilin';
      String inputEmail = "dadie.emilin@gmail.com";
      String inputAddress = '14 rue de Mulhouse';
      String inputPassword = "azerty";

      MockUserRepository repositoryMock = MockUserRepository();
      var mockResponse = user;
      when(repositoryMock.signUpUser(user)).thenAnswer((_) => Future.value(mockResponse));

      mockBloc.changeName(inputName);
      mockBloc.changeEmail(inputEmail);
      mockBloc.changeAddress(inputAddress);
      mockBloc.changePassword(inputPassword);

      mockBloc.name.listen((name)=> mockBloc.email.listen((email) => mockBloc.address.listen((address) => mockBloc.password.listen((password) async  {

        // Act
        User output = await mockBloc.signInUser();

        // Assert
        expect(output.email, equals('dadie.emilin@gmail.com'));
      }))));
    });
  });
}
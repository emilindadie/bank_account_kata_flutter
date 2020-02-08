
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/repositories/user.dart';


void main() {

  group("SignIn bloc", () {

    test("should update name when name controller sink", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputName = "Emilin";

      // Act
      mockBloc.updateName(inputName);

      mockBloc.name.listen((onData){
        // Assert
        expect(onData, equals("Emilin"));
      });
    });


    test("should update email when email controller sink", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputEmail = "dadie.emilin@gmail.com";

      // Act
      mockBloc.updateEmail(inputEmail);

      mockBloc.email.listen((onData){
        // Assert
        expect(onData, equals("dadie.emilin@gmail.com"));
      });
    });

    test("should update address when address controller sink", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputPassword = "14 rue de Mulhouse";

      // Act
      mockBloc.updateAddress(inputPassword);

      mockBloc.address.listen((onData){
        // Assert
        expect(onData, equals("14 rue de Mulhouse"));
      });
    });

    test("should update password when password controller sink", () async {
      // Arrange
      SignUpBloc mockBloc = SignUpBloc();
      String inputPassword = "azerty";

      // Act
      mockBloc.updatePassword(inputPassword);

      mockBloc.password.listen((onData){
        // Assert
        expect(onData, equals("azerty"));
      });
    });

    test("should return signUp user when having valid signUp dto", () async {
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

      mockBloc.updateName(inputName);
      mockBloc.updateEmail(inputEmail);
      mockBloc.updateAddress(inputAddress);
      mockBloc.updatePassword(inputPassword);

      mockBloc.name.listen((name)=> mockBloc.email.listen((email) => mockBloc.address.listen((address) => mockBloc.password.listen((password) async  {

        // Act
        User output = await mockBloc.signUpUser();

        // Assert
        expect(output.email, equals('dadie.emilin@gmail.com'));
      }))));
    });
  });
}
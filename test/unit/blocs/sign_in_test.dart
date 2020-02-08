
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mock/repositories/user.dart';


void main() {

  group("SignIn bloc", () {
    test("should update email when email controller sink", () async {
      // Arrange
      SignInBloc mockBloc = SignInBloc();
      String inputEmail = "dadie.emilin@gmail.com";

      // Act
      mockBloc.updateEmail(inputEmail);

      mockBloc.email.listen((onData){
        // Assert
        expect(onData, equals("dadie.emilin@gmail.com"));
      });
    });

    test("should update email when password controller sink", () async {
      SignInBloc mockBloc = SignInBloc();
      String inputPassword = "azerty";
      mockBloc.updatePassword(inputPassword);

      mockBloc.password.listen((onData){
        expect(onData, equals("azerty"));
      });
    });


    test("should return signIn user when having existing email and password in the system", () async {
      SignInBloc mockBloc = SignInBloc();
      String inputEmail = "dadie.emilin@gmail.com";
      String inputPassword = "azerty";

      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      MockUserRepository repositoryMock = MockUserRepository();
      var mockResponse = LoginResponse(accessToken: 'toto');
      when(repositoryMock.signInUser(user)).thenAnswer((_) => Future.value(mockResponse));

      mockBloc.updateEmail(inputEmail);
      mockBloc.updatePassword(inputPassword);

      mockBloc.email.listen((email)=> mockBloc.password.listen((password) async {
        LoginResponse output = await mockBloc.signInUser();
        expect(output.accessToken, equals('toto'));
      }));
    });
  });
}
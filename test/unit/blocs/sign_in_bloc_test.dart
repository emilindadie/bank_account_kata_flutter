
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/api/api_response.dart';
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../common/mock/repositories/user.dart';


void main() {

  group("SignIn bloc", () {
    test("should update email when email controller sink", () async {
      // Arrange
      SignInBloc bloc = SignInBloc(repository: UserRepository());
      String inputEmail = "dadie.emilin@gmail.com";

      // Act
      bloc.updateEmail(inputEmail);

      bloc.email.listen((onData){
        // Assert
        expect(onData, equals("dadie.emilin@gmail.com"));
      });
    });

    test("should update email when password controller sink", () async {
      SignInBloc bloc = SignInBloc(repository: UserRepository());
      String inputPassword = "azerty";
      bloc.updatePassword(inputPassword);

      bloc.password.listen((onData){
        expect(onData, equals("azerty"));
      });
    });


    test("should return signIn user when having existing email and password in the system", () async {
      SignInBloc bloc = SignInBloc(repository: UserRepository());
      String inputEmail = "dadie.emilin@gmail.com";
      String inputPassword = "azerty";

      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');
      MockUserRepository repositoryMock = MockUserRepository();
      ApiResponse<LoginResponse> mockResponse = ApiResponse(data: LoginResponse(accessToken: 'toto'));
      when(repositoryMock.signInUser(user)).thenAnswer((_) => Future.value(mockResponse));

      bloc.updateEmail(inputEmail);
      bloc.updatePassword(inputPassword);

      bloc.email.listen((email)=> bloc.password.listen((password) async {
        ApiResponse<LoginResponse> output = await bloc.signInUser();
        expect(output.data.accessToken, equals('toto'));
      }));
    });
  });
}
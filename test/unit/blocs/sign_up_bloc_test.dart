
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../common/mock/repositories/user.dart';



void main() {

  group("SignIn bloc", () {
    test("should update name when name controller sink", () async {
      // Arrange
      SignUpBloc bloc = SignUpBloc(repository: UserRepository());
      String inputName = "Emilin";

      // Act
      bloc.updateName(inputName);

      bloc.name.listen((onData){
        // Assert
        expect(onData, equals("Emilin"));
      });
    });


    test("should update email when email controller sink", () async {
      SignUpBloc bloc = SignUpBloc(repository: UserRepository());
      String inputEmail = "dadie.emilin@gmail.com";

      bloc.updateEmail(inputEmail);

      bloc.email.listen((onData){
        expect(onData, equals("dadie.emilin@gmail.com"));
      });
    });

    test("should update address when address controller sink", () async {
      SignUpBloc bloc = SignUpBloc(repository: UserRepository());
      String inputPassword = "14 rue de Mulhouse";

      bloc.updateAddress(inputPassword);

      bloc.address.listen((onData){
        expect(onData, equals("14 rue de Mulhouse"));
      });
    });

    test("should update password when password controller sink", () async {
      SignUpBloc bloc = SignUpBloc(repository: UserRepository());
      String inputPassword = "azerty";

      bloc.updatePassword(inputPassword);

      bloc.password.listen((onData){
        expect(onData, equals("azerty"));
      });
    });

    test("should return signUp user when having valid signUp dto", () async {
      SignUpBloc bloc = SignUpBloc(repository: UserRepository());
      User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

      String inputName = 'Emilin';
      String inputEmail = "dadie.emilin@gmail.com";
      String inputAddress = '14 rue de Mulhouse';
      String inputPassword = "azerty";

      MockUserRepository repositoryMock = MockUserRepository();
      User mockResponse = user;
      when(repositoryMock.signUpUser(user)).thenAnswer((_) => Future.value(mockResponse));

      bloc.updateName(inputName);
      bloc.updateEmail(inputEmail);
      bloc.updateAddress(inputAddress);
      bloc.updatePassword(inputPassword);

      bloc.name.listen((name)=> bloc.email.listen((email) => bloc.address.listen((address) => bloc.password.listen((password) async  {
        User output = await bloc.signUpUser();
        expect(output.email, equals('dadie.emilin@gmail.com'));
      }))));
    });
  });
}
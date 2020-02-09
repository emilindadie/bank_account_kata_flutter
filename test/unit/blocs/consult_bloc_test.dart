
import 'package:bank_account_kata_flutter/src/blocs/consult_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mock/repositories/account.dart';


void main() {

  group("Consult bloc", () {
    MockAccountRepository repositoryMock = MockAccountRepository();
    List<Account> mockLoadAccountsResponse =  new List<Account>();
    when(repositoryMock.loadAccounts(1, 'accessToken')).thenAnswer((_) => Future.value(mockLoadAccountsResponse));
    User user = User(id: 1, name: 'Emilin', email: 'dadie.emilin@gmail.com', address: '14 rue de Mulhouse', password: 'azerty');

    test("should update accountName when account controller sink", () async {
      // Arrange
      ConsultBloc bloc = ConsultBloc(user: user, access_token: 'accessToken');
      String accountName = "Compte A";

      // Act
      bloc.updateAccount(accountName);

      bloc.account.listen((onData){
        // Assert
        expect(onData, equals("Compte A"));
      });
    });
  });
}
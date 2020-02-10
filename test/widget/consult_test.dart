import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/consult_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/redux/app_reducer.dart';
import 'package:bank_account_kata_flutter/src/redux/app_state.dart';
import 'package:bank_account_kata_flutter/src/redux/auth_state.dart';
import 'package:bank_account_kata_flutter/src/redux/home_state.dart';
import 'package:bank_account_kata_flutter/src/ui/consult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import '../common/mock/repositories/account.dart';


void main() {
  testWidgets('should find 4 accounts list when get user accounts list is called at page init', (WidgetTester tester) async {
    // Store
    final store = Store<AppState>(
      appReducer,
      initialState:
      AppState(authState: AuthState(isAuthenticated: false, user: null),  homeState : HomeState(currentIndex: 0, title: 'CONSULT')),
    );

    List<Account> accounts = List();
    accounts.add(Account(name: "Compte A"));
    accounts.add(Account(name: "Compte B"));
    accounts.add(Account(name: "Compte C"));
    accounts.add(Account(name: "Compte D"));

    final repositoryMock = MockAccountRepository();
    when(repositoryMock.loadAccounts(1, "accessToken")).thenAnswer((_) => Future.value(accounts));

    await tester.pumpWidget(StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Flutter Test Consult page',
            home: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return MyBlocProvider<ConsultBloc>(
                  bloc: ConsultBloc(
                      repository: repositoryMock,
                      user: User(id: 1),
                      accessToken: 'accessToken'),
                  child: ConsultPage(title: state.homeState.title),
                );
              }
            )
        )));

    await tester.pump(Duration.zero);

    expect(find.text('CONSULT'), findsOneWidget);

    expect(find.text('Compte A'), findsOneWidget);
    expect(find.text('Compte B'), findsOneWidget);
    expect(find.text('Compte C'), findsOneWidget);
    expect(find.text('Compte D'), findsOneWidget);
  });
}

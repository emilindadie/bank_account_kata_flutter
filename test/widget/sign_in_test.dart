import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/redux/app_reducer.dart';
import 'package:bank_account_kata_flutter/src/redux/app_state.dart';
import 'package:bank_account_kata_flutter/src/redux/auth_state.dart';
import 'package:bank_account_kata_flutter/src/ui/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:redux/redux.dart';


void main() {
  testWidgets('should having desabled login button when having empty email and password', (WidgetTester tester) async {
    // Store
    final store = Store<AppState>(
      appReducer,
      initialState:
          AppState(authState: AuthState(isAuthenticated: false, user: null)),
    );

    await tester.pumpWidget(StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Flutter Test Login page',
            home: MyBlocProvider<SignInBloc>(
              bloc: SignInBloc(),
              child: SignInPage(),
            ))));

    await tester.pump(Duration.zero);

    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('SignIn'), findsOneWidget);
    expect(find.text('You dont have account, SignUp'), findsOneWidget);

    await tester.tap(find.text('SignIn'));
    expect(tester.widget<RaisedButton>(find.byKey(Key('loginSubmitButton'))).enabled, isFalse);
  });
}

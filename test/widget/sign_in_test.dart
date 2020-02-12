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
  testWidgets('should having disabled login button when having empty form', (WidgetTester tester) async {
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
              child: SignInPage(createdUser: false),
            ))));

    await tester.pump(Duration.zero);

    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('SignIn'), findsOneWidget);
    expect(find.text('You dont have account, SignUp'), findsOneWidget);

    expect(tester.widget<RaisedButton>(find.byKey(Key('loginSubmitButton'))).enabled, isFalse);
  });

  testWidgets('should having enabled login button when having valid form', (WidgetTester tester) async {
    // Store
    final store = Store<AppState>(
      appReducer,
      initialState:
      AppState(authState: AuthState(isAuthenticated: false, user: null)),
    );

    SignInBloc bloc = SignInBloc();
    await tester.pumpWidget(StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'Flutter Test Login page',
            home: MyBlocProvider<SignInBloc>(
              bloc: bloc,
              child: SignInPage(createdUser: false),
            ))));

    await tester.pump(Duration.zero);

    bloc.updateEmail("dadie.emilin@gmail.com");
    bloc.updatePassword("azerty");

    bloc.email.listen((email)=> bloc.password.listen((password) async {
      await tester.pump(Duration.zero);
      expect(tester.widget<RaisedButton>(find.byKey(Key('loginSubmitButton'))).enabled, isTrue);
    }));
  });
}

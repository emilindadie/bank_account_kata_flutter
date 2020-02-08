import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/ui/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('should having disabled signUp button when having empty form', (WidgetTester tester) async {

    await tester.pumpWidget(
          MaterialApp(
            title: 'Flutter Test Register page',
            home: MyBlocProvider<SignUpBloc>(
              bloc: SignUpBloc(),
              child: SignUpPage(),
            )));

    await tester.pump(Duration.zero);

    expect(find.text('REGISTER'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    expect(tester.widget<RaisedButton>(find.byKey(Key('registerSubmitButton'))).enabled, isFalse);
  });

  testWidgets('should having enabled login button when having valid form', (WidgetTester tester) async {

    SignUpBloc bloc = SignUpBloc();
    await tester.pumpWidget(
        MaterialApp(
            title: 'Flutter Test Register page',
            home: MyBlocProvider<SignUpBloc>(
              bloc: bloc,
              child: SignUpPage(),
            )));

    await tester.pump(Duration.zero);

    bloc.updateName("Emilin");
    bloc.updateEmail("dadie.emilin@gmail.com");
    bloc.updateAddress("Rosny");
    bloc.updatePassword("azerty");

    bloc.name.listen((name) => bloc.email.listen((email)=> bloc.address.listen((address) => bloc.password.listen((password) async {
      await tester.pump(Duration.zero);
      expect(tester.widget<RaisedButton>(find.byKey(Key('registerSubmitButton'))).enabled, isTrue);
    }))));
  });
}

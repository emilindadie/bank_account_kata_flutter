import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:bank_account_kata_flutter/src/ui/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SignUpBloc registerBloc = MyBlocProvider.of<SignUpBloc>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF17479E), //change your color here
          ),
          title: Text("REGISTER", style: TextStyle(color: Color(0xFF17479E))),
          elevation: 0.0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Color(0xFFEEEEEE),
                height: 2.0,
              ),
              preferredSize: Size.fromHeight(2.0)),
        ),
        //resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            nameField(registerBloc),
            emailField(registerBloc),
            addressField(registerBloc),
            passwordField(registerBloc),
            buttonField(registerBloc, context)
          ],
        )));
  }

  Widget nameField(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: bloc.updateName,
              decoration: InputDecoration(
                hintText: 'Emilin DADIE',
                labelText: 'Name',
                errorText: snapshot.error,
              ),
            ));
      },
    );
  }

  Widget emailField(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: bloc.updateEmail,
              decoration: InputDecoration(
                hintText: 'toto@example.com',
                labelText: 'Email',
                errorText: snapshot.error,
              ),
            ));
      },
    );
  }

  Widget addressField(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.address,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: bloc.updateAddress,
              decoration: InputDecoration(
                hintText: '14 rue de mulhouse',
                labelText: 'Address',
                errorText: snapshot.error,
              ),
            ));
      },
    );
  }

  Widget passwordField(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              onChanged: bloc.updatePassword,
              decoration: InputDecoration(
                hintText: '*********',
                labelText: 'Password',
                errorText: snapshot.error,
              ),
            ));
      },
    );
  }

  Widget buttonField(SignUpBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.submitCheck,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return renderButton(null);
          } else {
            return renderButton(() async {
              try {
                var res = await bloc.signUpUser();
                goToLogin(context);
              } catch (e) {
                final snackBar = SnackBar(
                    backgroundColor: Color(0xFFCC270A),
                    content: Text(e.message));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            });
          }
        } else {
          return renderButton(null);
        }
      },
    );
  }

  Widget renderButton(Function f) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: RaisedButton(
              key: Key("registerSubmitButton"),
              onPressed: f,
              textColor: Colors.white,
              color: Color(0xFF17479E),
              child: Container(
                child: const Text('Register', style: TextStyle(fontSize: 20)),
              ),
            )));
  }

  void goToLogin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyBlocProvider<SignInBloc>(
            bloc: SignInBloc(repository: UserRepository()),
            child: SignInPage(createdUser: true),
          ),
        ));
  }
}

import 'dart:async';

import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_up_bloc.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';
import 'package:bank_account_kata_flutter/src/redux/app_action.dart';
import 'package:bank_account_kata_flutter/src/redux/app_state.dart';
import 'package:bank_account_kata_flutter/src/redux/auth_action.dart';
import 'package:bank_account_kata_flutter/src/redux/home_action.dart';
import 'package:bank_account_kata_flutter/src/repositories/user_repo.dart';
import 'package:bank_account_kata_flutter/src/ui/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'home.dart';

class SignInPage extends StatelessWidget {
  SignInBloc signInBloc;
  bool createdUser = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SignInPage({this.createdUser}) {
    if (createdUser) {
      scheduleMicrotask(() => _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Color(0xFF82B312),
            content: Text('Your account has been created'),
          )));
      this.createdUser = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    signInBloc = MyBlocProvider.of<SignInBloc>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("LOGIN", style: TextStyle(color: Color(0xFF17479E))),
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
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                emailField(signInBloc),
                passwordField(signInBloc),
                buttonField(signInBloc, context),
              ],
            )),
            new Positioned(
              bottom: 0.0,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: signUpPageField(context)),
            ),
          ],
        ));
  }

  Widget emailField(SignInBloc bloc) {
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

  Widget passwordField(SignInBloc bloc) {
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

  Widget buttonField(SignInBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.submitCheck,
      builder: (context, snapshot) {
        return new StoreConnector<AppState, Function>(converter: (store) {
          return (User user, String accessToken) => {
                store.dispatch(AppAction(
                    authAction: AuthAction(
                        type: 'load_user',
                        user: user,
                        accessToken: accessToken),
                    homeAction: HomeAction(type: 'consult'))),
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => HomePage()))
              };
        }, builder: (context, callback) {
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                    key: Key("loginSubmitButton"),
                    onPressed: snapshot.hasData && snapshot.data
                        ? null
                        : () async {
                            try {
                              var res = await bloc.signInUser();
                              callback(res.data.user, res.data.accessToken);
                            } catch (e) {
                              final snackBar = SnackBar(
                                  backgroundColor: Color(0xFFCC270A),
                                  content: Text(e.message));
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                    textColor: Colors.white,
                    color: Color(0xFF17479E),
                    child: Container(
                      child:
                          const Text('SignIn', style: TextStyle(fontSize: 20)),
                    ),
                  )));
        });
      },
    );
  }

  Widget signUpPageField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            signInBloc.dispose();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBlocProvider<SignUpBloc>(
                    bloc: SignUpBloc(repository: UserRepository()),
                    child: SignUpPage(),
                  ),
                ));
          },
          child: Container(
            child: const Text('You dont have account, SignUp',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Color(0xFF17479E))),
          ),
        ));
  }
}

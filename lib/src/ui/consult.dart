
import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/consult_bloc.dart';
import 'package:bank_account_kata_flutter/src/blocs/sign_in_bloc.dart';
import 'package:bank_account_kata_flutter/src/listener/onClickListener.dart';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/redux/app_action.dart';
import 'package:bank_account_kata_flutter/src/redux/app_state.dart';
import 'package:bank_account_kata_flutter/src/redux/auth_action.dart';
import 'package:bank_account_kata_flutter/src/redux/home_action.dart';
import 'package:bank_account_kata_flutter/src/ui/sign_in.dart';
import 'package:bank_account_kata_flutter/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_redux/flutter_redux.dart';

import 'consult_choice.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ConsultPage extends StatelessWidget implements OnClickListener {
  TextEditingController _textFieldController = TextEditingController();

  BuildContext _context;
  ConsultBloc consultBloc;
  String title;

  ConsultPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _context = context;
    consultBloc = MyBlocProvider.of<ConsultBloc>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            icon: Icon(Icons.person, color: Color(0xFF17479E)),
            itemBuilder: (BuildContext context) {
              return ConsultChoice.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
          // action button
          // action butt
        ],
        title: Text(title, style: TextStyle(color: Color(0xFF17479E))),
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
      body: StreamBuilder<List<Account>>(
          stream: consultBloc.accounts,
          builder: (context, snapshot) {
            print('build');
            if (snapshot.hasData) {
              return ListView(
                  children: _buildAccountList(context, snapshot.data));
            } else {
              return Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //openDialog(context);
          showSimpleCustomDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF17479E),
      ),
    );
  }

  List<Widget> _buildAccountList(BuildContext context, List<Account> accounts) {
    return accounts.map((account) => renderAccounts(context, account)).toList();
  }

  Widget renderAccounts(BuildContext context, Account account) {
    return CustomCardItemList(
        height: 100.0,
        modelId: "account",
        modelData: account,
        enableClick: true,
        onClickListener: this,
        marginTop: 10.0,
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Color(0xFF17479E),
            border: new Border.all(
              width: 1.0,
              color: Color(0xFF17479E),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  account.name,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  account.solde.toString() + ' €',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void onClick(modelId, modelData) async {
    switch (modelId) {
      case "connotClick":
        print('Error');
        break;

      case "account":
        break;
    }
  }

  void choiceAction(String choice) {
    if (choice == ConsultChoice.SignOut) {
      logOut();
    }
  }

  void logOut() {
    final store = StoreProvider.of<AppState>(_context);
    store.dispatch(AppAction(
        authAction: AuthAction(type: 'log_out'),
        homeAction: HomeAction(type: '0')));
    Navigator.of(_context).pushReplacement(new MaterialPageRoute(
        builder: (context) =>
            MyBlocProvider<SignInBloc>(bloc: SignInBloc(), child: SignInPage())));
  }

  void showSimpleCustomDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
          height: 300.0,
          width: 300.0,
          child: StreamBuilder(
            stream: consultBloc.account,
            builder: (context, snapshot) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Create Account',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'For create a new bank account, please taped account name below.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: consultBloc.updateAccount,
                            decoration: InputDecoration(
                              labelText: 'Account Name',
                              errorText: snapshot.error,
                            ),
                          ))),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          color: Color(0xFF5274CC),
                          onPressed: snapshot.data.toString().length > 0
                              ? () => createAccount(snapshot.data)
                              : null,
                          child: Text(
                            'Create',
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RaisedButton(
                          color: Color(0xFFCC6650),
                          onPressed: () {
                            consultBloc.resetPopup();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel!',
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );

    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  void createAccount(String accountName) {
    final store = StoreProvider.of<AppState>(_context);
    consultBloc
        .createAccount(accountName, store.state.authState.user)
        .then((onValue) {
      consultBloc.loadAccounts();
      Navigator.pop(_context);
    });
  }
}

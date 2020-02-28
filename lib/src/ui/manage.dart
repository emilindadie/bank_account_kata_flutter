import 'package:async/async.dart';
import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/manage_bloc.dart';
import 'package:bank_account_kata_flutter/src/listener/onClickListener.dart';
import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart';
import 'consult_choice.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ManagePage extends StatelessWidget implements OnClickListener {
  String title;
  ManageBloc manageBloc;
  ManagePage({Key key, @required this.title}) : super(key: key);

  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    manageBloc = MyBlocProvider.of<ManageBloc>(context);

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
      body: Container(
          child: Column(
        children: <Widget>[
          new Container(
              height: 100.0,
              child: StreamBuilder<String>(
                  stream: manageBloc.action,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildActionList(snapshot.data, 'Withdraw'),
                            _buildActionList(snapshot.data, 'Deposit'),
                          ]);
                    } else {
                      return Center();
                    }
                  })),
          new Container(
              margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
              height: 380.0,
              child: StreamBuilder<List<Account>>(
                  stream: manageBloc.accounts,
                  builder: (context, snapshotAccount) {
                    if (snapshotAccount.hasData &&
                        snapshotAccount.data.length > 0) {
                      return StreamBuilder<int>(
                          stream: manageBloc.selectedAccountIndex,
                          builder: (context, snapshotIndex) {
                            return ListView(
                                children: _buildAccountList(context,
                                    snapshotAccount.data, snapshotIndex.data));
                          });
                    } else {
                      return Center(
                        child: Text("No account to show",
                            style: TextStyle(
                                color: Color(0xFF395280), fontSize: 16.0)),
                      );
                    }
                  })),
          new Container(
            child: amountField(manageBloc),
          )
        ],
      )),
      floatingActionButton: StreamBuilder(
          stream: manageBloc.disabledSubmit,
          builder: (context, snapshot) {
            if(snapshot.hasData){
                return fabButton(snapshot.data, Color(0xFF17479E), Color(0xFFB9BDBA));
            } else {
              return fabButton(true, Color(0xFF17479E), Color(0xFFB9BDBA));
            }
          }),
    );
  }

  Widget amountField(ManageBloc bloc) {
    return StreamBuilder(
      stream: bloc.amount,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: bloc.updateAmount,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                errorText: snapshot.error,
              ),
            ));
      },
    );
  }

  List<Widget> _buildAccountList(
      BuildContext context, List<Account> accounts, int selectedIndex) {
    return accounts
        .map((account) => renderAccounts(
            context, account, accounts.indexOf(account), selectedIndex))
        .toList();
  }

  Widget renderAccounts(
      BuildContext context, Account account, int index, int selectedIndex) {
    return CustomCardItemList(
        height: 100.0,
        modelId: "account",
        modelData: account,
        enableClick: true,
        index: index,
        onClickListener: this,
        marginTop: 10.0,
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color:
                selectedIndex == index ? Color(0xFF17479E) : Color(0xFFEEEEE),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  account.name,
                  style: selectedIndex == index
                      ? TextStyle(color: Colors.white, fontSize: 16.0)
                      : TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                Text(
                  account.solde.toString() + ' €',
                  style: selectedIndex == index
                      ? TextStyle(color: Colors.white, fontSize: 16.0)
                      : TextStyle(color: Colors.black, fontSize: 16.0),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildActionList(String action, String title) {
    return CustomCardItemList(
        modelId: title,
        modelData: '',
        onClickListener: this,
        width: 200,
        enableClick: true,
        marginTop: 10.0,
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: action == title ? Color(0xFF17479E) : Color(0xFFEEEEE),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: action == title
                      ? TextStyle(color: Colors.white, fontSize: 16.0)
                      : TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ));
  }

  Widget fabButton(bool disabledButton, Color enabledColor, Color desabledColor){
    return FloatingActionButton(
      onPressed: disabledButton
          ? null
          : () async {
        StreamZip requiredStreams = StreamZip([
          manageBloc.action,
          manageBloc.amount,
          manageBloc.selectedAccount
        ]);

        requiredStreams.listen((onData) async {
          int amount = 0;
          Account account = onData[2];
          var buffer = new StringBuffer();
          if (onData[0] == 'Withdraw') {
            buffer.write("-");
            buffer.write(onData[1]);
            amount = int.parse(buffer.toString());
          } else {
            amount = int.parse(onData[1]);
          }

          try {
            var res = await manageBloc.createOperation(amount, account.id);
            final snackBar = SnackBar(
                backgroundColor: Color(0xFF82B312),
                content: Text("Your operation was done with success"));
                manageBloc.loadAccounts();
            Scaffold.of(_context).showSnackBar(snackBar);
          } catch (e) {
            final snackBar = SnackBar(
                backgroundColor: Color(0xFFCC270A),
                content: Text(e.message));
            Scaffold.of(_context).showSnackBar(snackBar);
          }
        });
      },
      child: Icon(Icons.done),
      backgroundColor:  disabledButton ? desabledColor : enabledColor,
    );
  }
  void choiceAction(String choice) {
    if (choice == ConsultChoice.SignOut) {}
  }

  @override
  void onClick(modelId, modelData, index) {
    switch (modelId) {
      case 'Withdraw':
        manageBloc.updateAction('Withdraw');
        break;

      case 'Deposit':
        manageBloc.updateAction('Deposit');
        break;

      case 'account':
        manageBloc.updateSelectedAccountIndex(index);
        manageBloc.updateSelectedAccount(modelData);
        break;
    }
  }
}

import 'package:bank_account_kata_flutter/src/blocs/bloc_provider.dart';
import 'package:bank_account_kata_flutter/src/blocs/manage_bloc.dart';
import 'package:bank_account_kata_flutter/src/listener/onClickListener.dart';
import 'package:bank_account_kata_flutter/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'consult_choice.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ManagePage extends StatelessWidget implements OnClickListener  {

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
      body: StreamBuilder<String>(
          stream: manageBloc.action,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(child: Column(
                children: <Widget>[
                  new Container(
                    height: 100.0,
                    child: ListView(
                      // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildActionList(snapshot.data, 'Withdraw'),
                          _buildActionList(snapshot.data, 'Deposit'),
                        ]
                    ),
                  )
                ],
              )
              );
            } else {
              return Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //openDialog(context);
        },
        child: Icon(Icons.done),
        backgroundColor: Color(0xFF17479E),
      ),
    );
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
              color: action == title? Color(0xFF17479E) : Color(0xFFEEEEE),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: action == title? TextStyle(color: Colors.white, fontSize: 16.0) : TextStyle(color: Colors.black, fontSize: 16.0) ,
                  ),
                ],
              ),
            ),
          ));
  }
  void choiceAction(String choice) {
    if (choice == ConsultChoice.SignOut) {}
  }

  @override
  void onClick(modelId, modelData) {
    switch(modelId){
      case 'Withdraw':
        manageBloc.updateAction('Withdraw');
      break;

      case 'Deposit':
        manageBloc.updateAction('Deposit');
      break;
    }
  }
}

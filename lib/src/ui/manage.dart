import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'consult_choice.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class ManagePage extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  String title;

  ManagePage({Key key, @required this.title}) : super(key: key);

  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;

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
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //openDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF17479E),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == ConsultChoice.SignOut) {}
  }
}

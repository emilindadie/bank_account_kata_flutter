
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class ManageBloc implements BlocBase {

  BehaviorSubject<String> _actionController = BehaviorSubject<String>.seeded("Withdraw");
  Stream<String> get action => _actionController.stream;

  Function(String) get updateAction => _actionController.sink.add;

  void dispose(){
    _actionController.close();
  }

}
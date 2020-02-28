import 'dart:async';

import 'package:rxdart/rxdart.dart';

mixin ManageValidators{
  buttonValidator(BehaviorSubject<String> amountController) => StreamTransformer<bool,bool>.fromHandlers(
      handleData: (button,sink){
        if(amountController.value.length > 0 && int.parse(amountController.value)  != 0 ){
          sink.add(false);
        } else {
          sink.add(true);
        }
      }
  );
}

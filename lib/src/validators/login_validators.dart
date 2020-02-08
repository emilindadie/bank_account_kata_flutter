import 'dart:async';

import 'package:rxdart/rxdart.dart';

mixin LoginValidators{

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (email,sink){
        if(email.length > 0 && email.contains("@")){
          sink.add(email);
        }
        else if(email.length > 0){
          sink.addError("Email is not valid");
        }
      }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (password,sink){
        if(password.length > 0 && password.length>4){
          sink.add(password);
        }
        else if(password.length > 0 && password.length < 4){
          sink.addError("Password length should be greater than 4 chars.");
        }
      }
  );

  buttonValidator(BehaviorSubject<String> emailController, BehaviorSubject<String> passwordController) => StreamTransformer<bool,bool>.fromHandlers(
      handleData: (button,sink){
        if(emailController.value.length > 0 && emailController.value.contains("@") && passwordController.value.length > 4 ){
          sink.add(false);
        } else {
          sink.add(true);
        }
      }
  );

}

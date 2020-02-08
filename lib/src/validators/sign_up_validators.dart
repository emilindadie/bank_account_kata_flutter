import 'dart:async';

import 'package:rxdart/rxdart.dart';

mixin SignUpValidators{

  var nameValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (name,sink){
        if(name.length > 4){
          sink.add(name);
        }
        else if(name.length > 0 && name.length < 4){
          sink.addError("Name too short");
        }
      }
  );

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

  var addressValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (address,sink){
        if(address.length > 4){
          sink.add(address);
        }
        else if(address.length > 0 && address.length < 4){
          sink.addError("Address too short");
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

  buttonValidator(BehaviorSubject<String> nameController, BehaviorSubject<String> emailController, BehaviorSubject<String> addressController, BehaviorSubject<String> passwordController) => StreamTransformer<bool,bool>.fromHandlers(
      handleData: (button,sink){
        if(nameController.value.length > 4 && emailController.value.length > 0 && emailController.value.contains("@") &&  addressController.value.length > 4 && passwordController.value.length > 4 ){
          sink.add(false);
        } else {
          sink.add(true);
        }
      }
  );

}

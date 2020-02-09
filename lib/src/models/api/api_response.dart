import 'package:bank_account_kata_flutter/src/models/account/account.dart';
import 'package:bank_account_kata_flutter/src/models/base/base.dart';
import 'package:bank_account_kata_flutter/src/models/login_response/login_response.dart';
import 'package:bank_account_kata_flutter/src/models/user/user.dart';

import 'api_error.dart';

class ApiResponse<T extends BaseModel> {
  T data;
  ApiError error;

  ApiResponse({this.data, this.error});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.data != null && this.data is User){
      data['data']= this.data.toJson();
    }
    else if(this.data != null && this.data is LoginResponse){
      data['data']= this.data.toJson();
    }
    else if(this.data != null && this.data is Account){
      data['data']= this.data.toJson();
    }
    data['error'] != null ? this.error.toJson() : null;
    return data;
  }
}
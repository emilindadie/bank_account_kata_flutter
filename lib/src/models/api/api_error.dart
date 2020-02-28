
import 'package:bank_account_kata_flutter/src/models/base/base.dart';

class ApiError extends BaseModel {
  String message;
  ApiError({this.message});


  @override
  ApiError fromJson(Map<String, dynamic> json) {
    return ApiError(message: json['message']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
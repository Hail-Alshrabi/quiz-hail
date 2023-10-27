
import 'loginUserModel.dart';

class RegisterUserModel extends LoginUserModel{
  RegisterUserModel({bool? success, String? message,Result? result}) : super(success: success,message: message,result: result);

  RegisterUserModel.fromJson(Map<String, dynamic>? json): super.fromJson(json){

  }
}
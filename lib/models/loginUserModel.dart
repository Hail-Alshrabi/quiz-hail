
import 'ResponseModel.dart';

class LoginUserModel extends ResponseModel {
  LoginUserModel({bool? success, String? message,this.result}) : super(success: success,message: message);

  late final Result? result;

  LoginUserModel.fromJson(Map<String, dynamic>? json): super.fromJson(json){
    result = Result == null ? null : Result.fromJson(json?['result']);
  }

}

class Result {
  Result({
    this.userId,
    this.fullName,
    this.phoneNumber,
    this.password,
    this.emailUser,
    this.address,
    this.userStatus,
  });

  late final int? userId;
  late final String? fullName;
  late final String? phoneNumber;
  late final String? password;
  late final String? emailUser;
  late final String? address;
  late final String? userStatus;

  Result.fromJson(Map<String, dynamic>? json) {
   // userId = json?['userId'] ?? 0;
    userId = int.parse(json?['userId'] ?? '0');
    fullName = json?['fullName'] ?? '';
    phoneNumber = json?['phoneNumber'] ?? '';
    password = json?['password'] ?? '';
    emailUser = json?['emailUser'] ?? '';
    address = json?['address'] ?? '';
    userStatus = json?['userStatus'] ?? '';
  }

}

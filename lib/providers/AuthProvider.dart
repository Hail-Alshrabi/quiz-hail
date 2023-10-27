import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/loginUserModel.dart';
import '../models/registerUserModel.dart';
import '../services/rest_api_services.dart';

class AuthProvider extends ChangeNotifier {
  LoginUserModel? loginUserModel;
  RegisterUserModel? registerUserModel;
  //GoogleSignIn allows you to authenticate Google users.

  int userId = 0 ;
  String email ='';


  bool loading = false;

  getLoginUser(BuildContext context, Map map, String urlPage) async {
    try{
      loading = true;
      dynamic response = await RestApiServices().postData(context, map, urlPage);
      if(response !=null){
        loginUserModel = LoginUserModel.fromJson(response);
      }
      loading = false;
      notifyListeners();
    }catch(ex){
      loading = false;
      notifyListeners();
      print('AuthProvider----Error Exception ----->${ex}');
    }
  }

  getRegisterUser(BuildContext context, Map map, String urlPage) async {
    try{
      loading = true;

      dynamic response = await RestApiServices().postData(context, map, urlPage);
      if(response !=null){
        registerUserModel = RegisterUserModel.fromJson(response);
      }
      loading = false;
      notifyListeners();
    }catch(ex){
      loading = false;
      notifyListeners();
      print('AuthProvider----Error Exception ----->${ex}');
    }
  }


}

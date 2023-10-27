

import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

void navigationPush(context , widget){
  Navigator.push(context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
  );
}

void navigationPushAndRemoveUntil(context , widget){
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}

Decoration boxDecoration(){
  return  BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(1, 1), // changes position of shadow
      ),
    ],
  );
}

InputDecoration inputDecorationDropDownSearch(double width){
  return InputDecoration(
    filled: true,
    fillColor: AppColor.PrimaryColor.withOpacity(0.02),
    contentPadding: EdgeInsets.symmetric(vertical: width * 0.01 ,horizontal: width * 0.03),
    enabledBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: AppColor.PrimaryColor, width: 1),
      borderRadius: BorderRadius.circular(15.0),
      gapPadding: 2.0,
    ),
    focusedBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: AppColor.PrimaryColor, width: 1),
      borderRadius: BorderRadius.circular(15.0),
      gapPadding: 2.0,
    ),
    labelStyle: TextStyle(color:AppColor.PrimaryColor , fontSize: width * 0.04,fontWeight: FontWeight.w600),
    hintStyle: TextStyle(color:AppColor.GreyShade3, fontSize: width * 0.04, fontStyle: FontStyle.normal,),
  );
}





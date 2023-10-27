
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../constants/assets_path.dart';
import '../../widgets/toast.dart';
import '../constants/api_path.dart';

class RestApiServices {

  RestApiServices._();
  static final RestApiServices _instance =RestApiServices._();
  factory RestApiServices() => _instance;

  Future<dynamic> postData(BuildContext context ,Object map ,String urlPage) async {
    var jsonResponse;
    try{

      String? url = ApiPath.baseUrl +urlPage;
     late http.Response resPost;
      resPost = await http.post(Uri.parse(url),body: map );
      
      debugPrint('requestJson--url---${url}-->${map}');


      if(resPost.statusCode == 200){
        debugPrint('responseJson--url---${url}-->${resPost.body}');

        jsonResponse= json.decode(resPost.body);

      }else{
        debugPrint(' Error ${resPost.statusCode}حدث خطأ في الشبكة');
      }


    }on FormatException{
      // for convert json
      print('حدثت مشكلة عند جلب البيانات');
    }catch(ex){
      print('-----Error Exception ------->${ex}');

    }
    return jsonResponse;
  }


  Future<dynamic> postDataWithMultipartRequest(BuildContext context ,Map map ,File? file,String urlPage) async {
    var jsonResponse;
    try {

      String url = ApiPath.baseUrl +urlPage;
      var request = http.MultipartRequest("POST", Uri.parse(url));

      if(file !=null){
        var length = await file.length();
        print('length file------$length');
        var stream = http.ByteStream(file.openRead());

        var multipartFile = http.MultipartFile('file', stream, length, filename: basename(file.path));

        request.files.add(multipartFile);
      }
      map.forEach((key, value) {
        request.fields[key] = value ;
      });
      //for send request
      var myrequest = await request.send();

      var resPost = await http.Response.fromStream(myrequest) ;

      print('requestJson--url---${url}-->${map}');
      if(resPost.statusCode == 200){
        debugPrint('responseJson--url---${url}-->${resPost.body}');

        jsonResponse= json.decode(resPost.body);

      }else{
        print(' Error ${resPost.statusCode}حدث خطأ في الشبكة');
      }


    }on FormatException{
      // for convert json
      print('حدثت مشكلة عند جلب البيانات');
    }catch(ex){
      showToast(message:ex.toString() ,state: ToastStates.error);
      print('-----Error Exception ------->${ex}');

    }
    return jsonResponse;
  }

  Future<dynamic> getData(BuildContext context ,String urlPage) async {
    var jsonResponse;
    try{


      String url =ApiPath.baseUrl +'${urlPage}';
      http.Response resGet = await http.get(Uri.parse(url),);

      if(resGet.statusCode == 200){
        debugPrint('responseJson--url---${url}-->${resGet.body}');

        jsonResponse= json.decode(resGet.body);

      }else{
        print(' Error ${resGet.statusCode}حدث خطأ في الشبكة');
        showToast(message: ' Error ${resGet.statusCode}حدث خطأ في الشبكة', state: ToastStates.error);
      }


    }on FormatException{
      // for convert json
      print('حدثت مشكلة عند جلب البيانات');
    }catch(ex){
      print('-----Error Exception ------->${ex}');

    }
    return jsonResponse;
  }
}

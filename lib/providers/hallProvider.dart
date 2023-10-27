
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parties_hall_app/helper/common_helper.dart';
import 'package:parties_hall_app/widgets/toast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/hallModel.dart';
import '../services/rest_api_services.dart';

class HallProvider extends ChangeNotifier{
  final ImagePicker imagePicker = ImagePicker();

  File? imageShowingHall;
  File? image1;
  File? image2;
  File? image3;
  HallModel? hallModel;
  List<Result> hallList = [];
  List<Result> myBookingList = [];

  final cityList = ['صنعاء','عدن','تعز','عمران','البيضاء','الحديدة','المحويت','ذمار','حجة','إب','مأرب','صعدة','الضالع','المكلا'];

  bool loading = false;

  getHallByCilty(BuildContext context, Map map, String urlPage) async {
    try{
      hallList.clear();
      loading = true;
      dynamic response = await RestApiServices().postData(context, map, urlPage);
      if(response !=null){
        if(response['success']){

          hallList = response['result'] ==null ?[] : List<Result>.from((response['result'] ?? []).map((e) => Result.fromJson(e )).toList());
          hallList.sort((b,a)=> a.hallRatingStar!.compareTo(b.hallRatingStar as num));
        }else{
          showToast(message: response['message'], state: ToastStates.error);
        }
      }
      loading = false;
      notifyListeners();
    }catch(ex){
      loading = false;
      notifyListeners();
      print('AuthProvider----Error Exception ----->${ex}');
    }
  }

  getMyBooking(BuildContext context, Map map, String urlPage) async {
    try{
      myBookingList.clear();
      loading = true;
      dynamic response = await RestApiServices().postData(context, map, urlPage);
      if(response !=null){
        if(response['success']){

          myBookingList = response['result'] ==null ?[] : List<Result>.from((response['result'] ?? []).map((e) => Result.fromJson(e )).toList());
        }else{
          showToast(message: response['message'], state: ToastStates.error);
        }
      }
      loading = false;
      notifyListeners();
    }catch(ex){
      loading = false;
      notifyListeners();
      print('AuthProvider----Error Exception ----->${ex}');
    }
  }

  searchAdvancedHall(BuildContext context, Map map, String urlPage) async {
    try{
      hallList.clear();
      loading = true;
      dynamic response = await RestApiServices().postData(context, map, urlPage);
      if(response !=null){
        if(response['success']){

          hallList = response['result'] ==null ?[] : List<Result>.from((response['result'] ?? []).map((e) => Result.fromJson(e )).toList());
          // hallList.sort((b,a)=> a.hallRatingStar!.compareTo(b.hallRatingStar as num));
          _getCurrentLocation();
        }else{
          showToast(message: response['message'], state: ToastStates.error);
        }
      }
      loading = false;
      notifyListeners();
    }catch(ex){
      loading = false;
      notifyListeners();
      print('AuthProvider----Error Exception ----->${ex}');
    }
  }

  // get Current Location
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      distanceCalculation(position);
    }).catchError((e) {
      print(e);
    });
  }

  distanceCalculation(Position position) {

    for(var d in hallList){
      var km = CommonHelper.getDistanceFromLatLonInKm(position.latitude,position.longitude, d.longitude,d.longitude);
      // var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
      // d.distance = m/1000;
      d.distance = km;
      // print(getDistanceFromLatLonInKm(position.latitude,position.longitude, d.lat,d.lng));
    }
    hallList.sort((a, b) {
      return a.distance!.compareTo(b.distance as num);
    });
    notifyListeners();

  }

  String city = 'صنعاء';
  void changeCity(String s) {
    city = s;
    notifyListeners();
  }

  int selectedIndexCity = 0;
  void changeIndexCity(int index) {
    selectedIndexCity = index;
    notifyListeners();
  }

  Future openGallery(BuildContext context ,int i) async {
    if(await checkCameraAndGalleryPermission(context)){
      try {
        final XFile? _photoGallery =
        //await imagePicker.pickImage(source: ImageSource.gallery , imageQuality: 80,maxWidth: 1080 ,maxHeight: 608,);
        await imagePicker.pickImage(source: ImageSource.gallery , imageQuality: 75,maxWidth: 640 ,maxHeight: 480,);
        if(_photoGallery != null){
          if(i == 1){
            imageShowingHall = File(_photoGallery.path.toString() ??'');
          }
          if(i == 2){
            image1 = File(_photoGallery.path.toString() ??'');
          }
          if(i == 3){
            image2 = File(_photoGallery.path.toString() ??'');
          }
          if(i == 4){
            image3 = File(_photoGallery.path.toString() ??'');
          }

        }
        notifyListeners();
      } catch (error, s) {
        log('get image from gallery', error: error, stackTrace: s);
      }
    }
  }

   Future<bool> checkCameraAndGalleryPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted ;
    if (isGranted) {
      return true;
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ;
    if (isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    return false;
  }

}


import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/api_path.dart';
import '../constants/assets_path.dart';
import '../constants/colors_constants.dart';
import '../helper/common_helper.dart';
import '../models/hallModel.dart';
import '../widgets/customButton.dart';
import '../widgets/ratingBarWidgets.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({Key? key, required this.model}) : super(key: key);
  final Result model;
  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();



  @override
  Widget build(BuildContext context) {
    double height = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double width = CommonHelper.getScreenWidth(context);
    return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [

                const SizedBox(height: 10,),
                Text('تفاصيل العنوان',style: TextStyle(color: AppColor.PrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child:                 Text(widget.model.addressDetails.toString() ?? '',textAlign: TextAlign.right,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),

                ),
                const SizedBox(height: 10,),
                Text('معلومات الإتصال',style: TextStyle(color: AppColor.PrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child:Text(widget.model.phoneNumbers.toString() ?? '',textAlign: TextAlign.right,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),

                ),
                const SizedBox(height: 10,),
                Text('الموقع',style: TextStyle(color: AppColor.PrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),

                Container(
                  width: double.infinity,
                  height: 300.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        child:    MapPicker(
                          // pass icon widget
                          iconWidget: Icon(Icons.location_on ,color: AppColor.PrimaryColor,size: 60.0),
                          // SvgPicture.asset(
                          //   AssetsPath.icon_location,
                          //   height: 60,
                          //   color: AppColor.PrimaryColor,
                          // ),
                          //add map picker controller
                          mapPickerController: mapPickerController,
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            child: GoogleMap(
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              // hide location button
                              myLocationButtonEnabled: false,
                              mapType: MapType.normal,
                              //  camera position
                              initialCameraPosition: CameraPosition(
                                target: LatLng(double.parse(widget.model.latitude ?? '0'), double.parse(widget.model.longitude ?? '0')),
                                zoom: 15,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onCameraMoveStarted: () {
                                // notify map is moving
                                mapPickerController.mapMoving!();

                              },
                              onCameraMove: (cameraPosition) {
                               // initCameraPosition = cameraPosition;
                              },
                              onCameraIdle: () async {
                                // notify map stopped moving
                                mapPickerController.mapFinishedMoving!();
                                //get address name from camera position


                                try{
                                  // update the ui with the address
                                  // textController.text =
                                  // '${placemarks[2].country} ,${placemarks[2].administrativeArea} ,${placemarks[2].locality} ,${placemarks[2].street}';
                                  //print('${placemarks[2].name} ,${placemarks[2].administrativeArea},${placemarks[2].street}');
                                  //if(placemarks[2].name != null)
                                  // areaController.text = placemarks[2].name ?? '';
                                }catch(ex){
                                  print('AddAdress-----------${ex}');
                                }


                              },
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }
}

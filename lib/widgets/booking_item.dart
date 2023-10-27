import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parties_hall_app/widgets/toast.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/api_path.dart';
import '../constants/assets_path.dart';
import '../constants/colors_constants.dart';
import '../constants/string_constants.dart';
import '../helper/common_helper.dart';
import '../models/hallModel.dart';
import '../screens/hallBookingScreen.dart';
import '../services/endpoint.dart';
import '../services/rest_api_services.dart';
import '../utils/progressIndicatorDialog.dart';
import 'components.dart';
import 'customButton.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({Key? key, required this.model,required this.index ,required this.width,required this.height,}) : super(key: key);
  final Result model;
  final int index;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(left: 5,right: 5,),
      width: width,
      child: InkWell(
        onTap:(){

        } ,
        child: Container(
          width: width,
          // margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 10,),
          padding: const EdgeInsets.only(right: 5,top: 5,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.GreyShade5,width: 0.8,),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // image car
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.image_displaying != null && model.image_displaying != '' ? SizedBox(
                    width:width * 0.43 ,
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: width,
                        height: height * 0.18,
                        imageUrl:'${ApiPath.baseUrlImage}${model.image_displaying ?? ''}',
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Container(
                          height: height * 0.18,
                          color: Colors.white,
                          width: width,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[100]!,
                            highlightColor: Colors.grey[300]!,
                            child: Image.asset(
                              AssetsPath.icon_launcher,width: width,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Container(
                            height: height * 0.18,
                            width: width * 0.40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.GreyShade6,width: 0.5,),
                            ),
                            child: Image.asset(
                              AssetsPath.icon_launcher,
                            ),
                          );
                        },
                      ),
                    ),
                  ) : Container(
                    height: height * 0.18,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.GreyShade6,width: 0.5,),
                    ),
                    child: Image.asset(
                      AssetsPath.icon_launcher,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.hallName ?? '',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.035 ,fontWeight: FontWeight.w600,letterSpacing: 1.0,),),

                        Row(
                          children: [
                            Text('السعر : ',style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.03 ,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(model.price ?? '0',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.035 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
                                const SizedBox(width: 5,),
                                Expanded(child: Text('ريال',overflow: TextOverflow.ellipsis ,style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.03 ,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                                )
                              ],
                            ))
                          ],
                        ),

                        Text(model.address ?? '',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.030 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),

                      ],
                    ),
                  )),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('تاريخ الحجز :',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.04 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
                  const SizedBox(width: 5,),
                  Expanded(child: Text(model.date_booking ?? '',overflow: TextOverflow.ellipsis ,style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.03 ,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              CustomButton(
                onPressed: () async {

                  if (await CommonHelper.checkInternetConnection()) {
                    ProgressIndicatorDialog().show(context, text: 'جاري الحجز...');
                    dynamic response = await RestApiServices().postData(context,
                        {
                          'id':model.id.toString() ?? '0',
                          'status':'Cancel',
                        }, EndPoint.cancelBooking);
                    if(response !=null){
                      if(response['success']){
                        showToast(message: response['message'], state: ToastStates.success);
                      }else{
                        showToast(message: response['message'], state: ToastStates.error);
                      }
                    }
                    Navigator.of(context).pop();
                  } else {
                    showToast(message: txt_notInternet, state: ToastStates.error);

                  }

                },
                margin: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 8.0),
                width: width,
                bgColor: AppColor.PrimaryColor,
                bgOverlayColor: Colors.white.withOpacity(0.8),
                txtColor: Colors.white,
                text: 'إلغاء الحجز',
              ),
              const SizedBox(height: 10,),


            ],
          ),
        ),
      ),
    );
  }
}

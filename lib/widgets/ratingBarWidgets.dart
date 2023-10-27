import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parties_hall_app/providers/hallProvider.dart';
import 'package:parties_hall_app/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../constants/colors_constants.dart';
import '../constants/string_constants.dart';
import '../helper/common_helper.dart';
import '../services/endpoint.dart';
import '../services/rest_api_services.dart';
import 'customButton.dart';

class RatingBarWidgets extends StatelessWidget {
  const RatingBarWidgets({Key? key,required this.titleDialog,required this.hallId}) : super(key: key);
  final String titleDialog;
  final int hallId;
  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    final _provider = Provider.of<HallProvider>(context);
    double _rating = 1;
    return Container(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _myWidth,
              padding: const EdgeInsets.all(8.0) ,
              decoration: BoxDecoration(
                color: AppColor.PrimaryColor,
                  borderRadius:BorderRadius.only(topLeft:Radius.circular(15) ,topRight: Radius.circular(15))
              ),

              child: Text(
                titleDialog,
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: _myWidth * 0.04 ,fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 30,),
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating =rating;
                  print(_rating);
                },
              ),
                  const SizedBox(height: 30.0),

                 Directionality(textDirection: TextDirection.rtl, child:  Row(
                   children: [
                     Expanded(flex: 1,
                       child:    CustomButton(
                         onPressed: () async {


                             if (await CommonHelper.checkInternetConnection()) {
                               dynamic response = await RestApiServices().postData(context,
                                   {'hallId':hallId.toString(),'ratingStar':_rating.toInt().toString()}, EndPoint.ratingHall);
                               if(response !=null){
                                 if(response['success']){

                                   showToast(message: response['message'], state: ToastStates.success);
                                   Navigator.of(context).pop();
                                 }else{
                                   showToast(message: response['message'], state: ToastStates.error);
                                   Navigator.of(context).pop();
                                 }
                               }
                             } else {
                               showToast(message: txt_notInternet, state: ToastStates.error);

                             }



                         },
                         padding:const EdgeInsets.symmetric(vertical: 8.0,) ,
                         margin: const EdgeInsets.symmetric(
                             horizontal: 10.0, vertical: 8.0),
                         width: _myWidth,
                         bgColor: AppColor.PrimaryColor,
                         txtColor: Colors.white,
                         height: _myHeight * 0.08,
                         text:'إرسال',
                         textSize: _myWidth * 0.04,

                       ),
                     ),
                     const SizedBox(width: 10.0,),
                     Expanded(flex: 1,
                       child:    CustomButton(
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                         padding:const EdgeInsets.symmetric(vertical: 8.0,) ,
                         margin: const EdgeInsets.symmetric(
                             horizontal: 10.0, vertical: 8.0),
                         width: _myWidth,
                         bgColor: Colors.red,
                         txtColor: Colors.white,
                         height: _myHeight * 0.08,
                         text: 'خروج',
                         textSize: _myWidth * 0.04,
                       ),
                     ),
                   ],
                 ),)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

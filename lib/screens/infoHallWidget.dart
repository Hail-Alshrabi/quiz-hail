

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/api_path.dart';
import '../constants/assets_path.dart';
import '../constants/colors_constants.dart';
import '../helper/common_helper.dart';
import '../models/hallModel.dart';
import '../providers/AuthProvider.dart';
import '../widgets/customButton.dart';
import '../widgets/ratingBarWidgets.dart';
import '../widgets/toast.dart';

class InfoHallWidget extends StatefulWidget {
  const InfoHallWidget({Key? key, required this.model}) : super(key: key);
  final Result model;
  @override
  _InfoHallWidgetState createState() => _InfoHallWidgetState();
}

class _InfoHallWidgetState extends State<InfoHallWidget> {

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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    if(widget.model.image_displaying != null && widget.model.image_displaying != '')
                      SizedBox(
                        width:width * 0.60 ,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: width,
                            height: height * 0.18,
                            imageUrl:'${ApiPath.baseUrlImage}${widget.model.image_displaying ?? ''}',
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
                                width: width * 0.60,
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
                      ),
                    const SizedBox(width: 10,),
                    if(widget.model.image1 != null && widget.model.image1 != '')
                      SizedBox(
                        width:width * 0.60 ,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: width,
                            height: height * 0.18,
                            imageUrl:'${ApiPath.baseUrlImage}${widget.model.image1 ?? ''}',
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
                                width: width * 0.60,
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
                      ),
                    const SizedBox(width: 10,),
                    if(widget.model.image2 != null && widget.model.image2 != '')
                      SizedBox(
                        width:width * 0.60 ,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: width,
                            height: height * 0.18,
                            imageUrl:'${ApiPath.baseUrlImage}${widget.model.image2 ?? ''}',
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
                                width: width * 0.60,
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
                      ),
                    const SizedBox(height: 10,),
                    if(widget.model.image3 != null && widget.model.image3 != '')
                      SizedBox(
                        width:width * 0.60 ,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: width,
                            height: height * 0.18,
                            imageUrl:'${ApiPath.baseUrlImage}${widget.model.image3 ?? ''}',
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
                                width: width * 0.60,
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
                      ),
                  ],
                )
              ),
              const SizedBox(height: 10,),
              Text(widget.model.hallName ?? '',style: TextStyle(color: AppColor.PrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),

              Row(
                children: [
                  const SizedBox(width: 10,),
                  Icon(Icons.location_pin,color: Colors.blue,),
                  const SizedBox(width: 10,),
                  Expanded(child:Text(widget.model.address.toString() ?? '',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.035 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Text('السعر : ',style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.035 ,fontWeight: FontWeight.w600,letterSpacing: 0.5,),),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.model.price ?? '0',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.035 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
                      const SizedBox(width: 5,),
                      Expanded(child: Text('ريال',overflow: TextOverflow.ellipsis ,style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.03 ,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                      )
                    ],
                  ))
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Icon(Icons.star,color: Colors.yellow,),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.model.hallRatingStar.toString() ?? '1',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontSize: width * 0.035 ,fontWeight: FontWeight.bold,letterSpacing: 1.0,),),
                      const SizedBox(width: 5,),
                      Expanded(child: Text('تقييم',overflow: TextOverflow.ellipsis ,style: TextStyle(color: AppColor.PrimaryColor, fontSize: width * 0.03 ,fontWeight: FontWeight.w500,letterSpacing: 0.5,),),
                      )
                    ],
                  ))
                ],
              ),
              const SizedBox(height: 10,),
              Text('معلومات عن القاعة',style: TextStyle(color: Colors.black45,fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text(widget.model.info_hall.toString() ?? '',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
              const SizedBox(height: 10,),
              CustomButton(
                onPressed: () {
                  if(Provider.of<AuthProvider>(context,listen: false).userId == 0){
                    showToast(message: 'يرجى تسجيل الدخول', state: ToastStates.error);
                    return;
                  }

    showDialog(

      context: context,barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(15.0))),
            contentPadding: const EdgeInsets.all(0),
            content: StatefulBuilder(// You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                //  return  RatingBarWidgets(titleDialog: 'تقييم القاعة',hallId: widget.model.hallId ?? 0,);
                return  RatingBarWidgets(titleDialog: 'تقييم القاعة',hallId: widget.model.hallId ?? 0,);
                }));
      },
    );
  },
                margin: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 8.0),
                width: height,
                bgColor: AppColor.PrimaryColor,
                bgOverlayColor: Colors.white.withOpacity(0.8),
                txtColor: Colors.white,
                text: 'تقييم القاعة',
              ),
              const SizedBox(height: 10,),

            ],
          ),
        ),
      )
    );
  }
}

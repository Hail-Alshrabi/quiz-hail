import 'package:flutter/material.dart';

import '../../constants/colors_constants.dart';
import '../helper/common_helper.dart';
import '../models/hallModel.dart';
import '../widgets/arrowBackWidget.dart';
import 'bookingCalendarWidget.dart';
import 'contactUsWidget.dart';
import 'infoHallWidget.dart';


class HallBookingScreen extends StatefulWidget {
  const HallBookingScreen({Key? key, required this.model}) : super(key: key);
  final Result model;
  @override
  State<HallBookingScreen> createState() => _HallBookingScreenState();
}

class _HallBookingScreenState extends State<HallBookingScreen> {

  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    return  DefaultTabController(
        initialIndex: 0,  //optional, starts from 0, select the tab by default
        length:3,
        child:Scaffold(
            appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent,
              title:  Text('التفاصيل',textDirection: TextDirection.rtl , style: TextStyle(color:  AppColor.PrimaryColor,fontSize: 18.0 ,fontWeight:FontWeight.w600 ),),
              centerTitle: true, leading: ArrowBackWidget(myContext: context,),
            ),

            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Container(
                    color: AppColor.PrimaryColor,
                    child: TabBar(
                        indicatorColor: AppColor.GreyShade1,
                        tabs: [
                          Tab(text: "المعلومات",),
                          Tab(text: "التواصل",),
                          Tab(text: "الحجوزات",),

                        ]
                    ),
                  ),
                  Expanded(child: TabBarView(
                      children: [
                        InfoHallWidget(model: widget.model,),
                        ContactUsWidget(model: widget.model,),
                        BookingCalendarWidget(model: widget.model,),

                      ]
                  ))
                ],
              ),
            )
        )
    );
  }
}

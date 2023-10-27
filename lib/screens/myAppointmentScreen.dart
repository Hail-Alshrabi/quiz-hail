
import 'package:flutter/material.dart';
import 'package:parties_hall_app/constants/string_constants.dart';
import 'package:parties_hall_app/providers/AuthProvider.dart';
import 'package:parties_hall_app/providers/hallProvider.dart';
import 'package:parties_hall_app/services/endpoint.dart';
import 'package:provider/provider.dart';
import '../../constants/colors_constants.dart';
import '../../helper/common_helper.dart';
import '../widgets/booking_item.dart';
import '../widgets/hall_item.dart';
import '../widgets/loadingCircle.dart';
import '../widgets/toast.dart';



class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {


  @override
  void initState(){
    super.initState();
    final prov = Provider.of<HallProvider>(context,listen: false);
    if(Provider.of<AuthProvider>(context,listen: false).userId == 0){
      showToast(message: 'يرجى تسجيل الدخول', state: ToastStates.error);
    }else{
      prov.getMyBooking(context, {'userId':Provider.of<AuthProvider>(context,listen: false).userId.toString() ?? '0'}, EndPoint.getMyBooking);
    }
  }
  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    final _provider = Provider.of<HallProvider>(context);

    return Scaffold(
      // appBar:  AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColor.PrimaryColor,
      //   title:  Text('حجوزاتي',textDirection: TextDirection.rtl , style: TextStyle(color:  Colors.white,fontSize: _myWidth * 0.04),),
      //   centerTitle: true,
      //
      // ) ,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Colors.white,
            height:_myHeight ,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 10),

                    _provider.loading ? LoadingCircle(): ListView.builder(

                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _provider.myBookingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  BookingItem(
                          height: _myHeight,
                          width: _myWidth,
                          model:_provider.myBookingList[index] ,
                          index: index,
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:parties_hall_app/screens/accounts/loginUser.dart';
import 'package:parties_hall_app/screens/searchAdvancedScreen.dart';
import 'package:parties_hall_app/screens/searchScreen.dart';
import 'package:parties_hall_app/widgets/components.dart';
import 'package:provider/provider.dart';

import '../../constants/colors_constants.dart';
import '../../constants/string_constants.dart';
import '../../providers/bottomNavigationBarProvider.dart';

import '../constants/assets_path.dart';
import 'homePage.dart';
import 'myAppointmentScreen.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  final currentTab = [HomePageScreen(), MyAppointmentScreen(),SearchAdvancedScreen()];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);

    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('الخروج من التطبيق',textAlign: TextAlign.right,),
          content: Text('هل تريد الخروج من التطبيق؟',textAlign: TextAlign.right,),
          actions:[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child:Text('لا'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.PrimaryColor),
                  ),
                ),
                const SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child:Text('نعم'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.PrimaryColor),
                  ),
                ),
              ],
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
    return WillPopScope(onWillPop: showExitPopup,//call function on back button press
    child: Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: AppColor.PrimaryColor,
        title:  Text('$txt_appName ',textDirection: TextDirection.rtl , style: TextStyle(color:  Colors.white,fontSize: 16),),
        centerTitle: true,

      ) ,
      body:currentTab[provider.currentIndex],

      drawer: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:AppColor.PrimaryColor,
                ), //BoxDecoration
                child: Image.asset(AssetsPath.icon_launcher,), //UserAccountDrawerHeader
              ),

              ListTile(
                leading: const Icon(Icons.logout,color: AppColor.PrimaryColor,),
                title:  Text('تسجيل الخروج',style: TextStyle(color: AppColor.PrimaryColor,fontSize:16 ,),),
                onTap: () {
                  Navigator.pop(context);
                  navigationPushAndRemoveUntil(context, UserLogin());
                },
              ),


            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: provider.currentIndex,
        showElevation: false,
        backgroundColor: Colors.white.withOpacity(0.8),
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) =>provider.currentIndexFun = index,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('الرئيسية' ,textDirection: TextDirection.rtl,),
            activeColor: AppColor.PrimaryColor,
            inactiveColor: AppColor.PrimaryColor,
            textAlign: TextAlign.center,

          ),

          BottomNavyBarItem(
            icon: Icon(Icons.event_note_rounded),
            title: Text('حجوزاتي',textDirection: TextDirection.rtl,),
            activeColor: AppColor.PrimaryColor,
            inactiveColor: AppColor.PrimaryColor,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('بحث',textDirection: TextDirection.rtl,),
            activeColor: AppColor.PrimaryColor,
            inactiveColor: AppColor.PrimaryColor,
            textAlign: TextAlign.center,
          ),

        ],
      ),
    ),);
  }
}


import 'package:flutter/material.dart';
import 'package:parties_hall_app/constants/string_constants.dart';
import 'package:parties_hall_app/providers/hallProvider.dart';
import 'package:parties_hall_app/services/endpoint.dart';
import 'package:provider/provider.dart';
import '../../constants/colors_constants.dart';
import '../../helper/common_helper.dart';
import '../widgets/hall_item.dart';
import '../widgets/loadingCircle.dart';



class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {


  @override
  void initState(){
    super.initState();
    final prov = Provider.of<HallProvider>(context,listen: false);
    prov.getHallByCilty(context, {'city':prov.cityList[0]}, EndPoint.getAllHallByCity);
  }
  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    final _provider = Provider.of<HallProvider>(context);

return Scaffold(

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

                SizedBox(
                  width: _myWidth,
                  height: _myHeight * 0.065,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _provider.cityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  InkWell(
                        onTap: (){
                          _provider.changeIndexCity(index);
                          _provider.getHallByCilty(context, {'city':_provider.cityList[index]}, EndPoint.getAllHallByCity);

                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 7,left: 1,),
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                          decoration: BoxDecoration(
                            color: _provider.selectedIndexCity == index ? AppColor.PrimaryColor : AppColor.PrimaryColor.withOpacity(0.05) ,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text('${_provider.cityList[index]}',style: TextStyle(color: _provider.selectedIndexCity == index ? Colors.white : AppColor.PrimaryColor, fontSize: _myWidth * 0.032 ,fontWeight: FontWeight.w600,),) ,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),

              _provider.loading ? LoadingCircle(): ListView.builder(

                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: _provider.hallList.length,
                itemBuilder: (BuildContext context, int index) {
                  return  HallItem(
                    height: _myHeight,
                    width: _myWidth,
                    model:_provider.hallList[index] ,
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

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parties_hall_app/models/hallModel.dart';
import 'package:parties_hall_app/providers/hallProvider.dart';
import 'package:parties_hall_app/services/endpoint.dart';
import 'package:provider/provider.dart';

import '../constants/colors_constants.dart';
import '../constants/string_constants.dart';
import '../helper/common_helper.dart';
import '../helper/form_validator.dart';
import '../widgets/arrowBackWidget.dart';
import '../widgets/components.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextForm.dart';
import '../widgets/hall_item.dart';
import '../widgets/toast.dart';

class SearchAdvancedScreen extends StatefulWidget {
  const SearchAdvancedScreen({Key? key}) : super(key: key);
  @override
  State<SearchAdvancedScreen> createState() => _SearchAdvancedScreenState();
}

class _SearchAdvancedScreenState extends State<SearchAdvancedScreen> {
  final _keyForm = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final priceController = TextEditingController();

  Position? _currentPosition;
  String groupValue ='ByName';


  @override
  void initState(){
    super.initState();
    Provider.of<HallProvider>(context,listen: false).hallList.clear();

  }

  @override
  Widget build(BuildContext context) {
    double _myHeight = CommonHelper.getScreenHeight(context) - CommonHelper.getSizePaddingTopScreen(context);
    double _myWidth = CommonHelper.getScreenWidth(context);
    final _provider = Provider.of<HallProvider>(context);
    return SafeArea(
      child: Scaffold(

        body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(top: 5.0,bottom:10.0 ,right: 5.0,left: 5.0) ,
              child: Form(
                  key: _keyForm,
                  child: Column(
                    children: [

                      Container(
                        width:_myWidth  ,
                        padding:const EdgeInsets.symmetric(horizontal: 5,vertical: 5,),
                        decoration : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(flex:1,child:  ListTile(
                                  title: const Text('الإسم'),
                                  leading: Radio<String>(
                                    value: 'ByName',
                                    groupValue: groupValue,
                                    onChanged: (String? value) {
                                      _provider.hallList.clear();
                                      setState(() {
                                        groupValue = value ?? '';
                                      });
                                    },
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                Expanded(flex:1,child:  ListTile(
                                  title: const Text('التاريخ'),
                                  leading: Radio<String>(
                                    value: 'ByDate',
                                    groupValue: groupValue,
                                    onChanged: (String? value) {
                                      _provider.hallList.clear();
                                      setState(() {
                                        groupValue = value ?? '';
                                      });
                                    },
                                  ),
                                ),),

                              ],
                            ),
                            Row(
                              children: [
                                Expanded(flex:1,child:  ListTile(
                                  title: const Text('السعر'),
                                  leading: Radio<String>(
                                    value: 'ByPrice',
                                    groupValue: groupValue,
                                    onChanged: (String? value) {
                                      _provider.hallList.clear();
                                      setState(() {
                                        groupValue = value ?? '';
                                      });
                                    },
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                Expanded(flex:1,child:  ListTile(
                                  title: const Text('الأقرب'),
                                  leading: Radio<String>(
                                    value: 'Nearest',
                                    groupValue: groupValue,
                                    onChanged: (String? value) {
                                      _provider.hallList.clear();
                                      setState(() {
                                        groupValue = value ?? '';
                                      });
                                    },
                                  ),
                                ),),
                              ],
                            ),

                            const SizedBox(height: 10,),
                            if(groupValue == 'ByName')
                              CustomTextForm(
                                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                                hint: 'إسم القاعة',
                                labelText: 'إسم القاعة',
                                validator: FormValidator.fieldValidator,
                                textEditController: nameController,
                                actionKeyboard: TextInputAction.none,
                                maxLength: 50,
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                filled: true,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                              ),

                            if(groupValue == 'ByDate')
                              CustomTextForm(
                                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                                hint:'التاريخ',
                                labelText: 'التاريخ',
                                validator: FormValidator.fieldValidator,
                                textEditController: dateController,
                                actionKeyboard: TextInputAction.none,
                                maxLength: 15,
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                filled: true,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                                readOnly: true,
                                onTap: () async {
                                  String _date = await CommonHelper.getDateFormatted(context);
                                  setState(() {
                                    dateController.text = _date;
                                  });
                                },
                              ),

                            if(groupValue == 'ByPrice')
                              CustomTextForm(
                                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                                hint: 'السعر',
                                labelText: 'السعر',
                                validator: FormValidator.fieldValidator,
                                textEditController: priceController,
                                textInputType: TextInputType.number,
                                actionKeyboard: TextInputAction.none,
                                maxLength: 10,
                                text_style: TextStyle(fontSize:_myWidth * 0.04 ),
                                filled: true,
                                fillColor: AppColor.PrimaryColor.withOpacity(0.02),
                              ),

                            const SizedBox(height: 10,),
                            CustomButton(
                              onPressed: () async {
                                LocationPermission permission;
                                permission = await Geolocator.requestPermission();

                                CommonHelper.dismissKeyBoard();
                                bool myValid = _keyForm.currentState!.validate();
                                if (myValid) {
                               if (await CommonHelper.checkInternetConnection()) {

                                  if(groupValue == 'ByName')
                                  _provider.searchAdvancedHall(context, {'keySearch':'ByName', 'name':nameController.text.toString().trim(),}, EndPoint.searchHall);
                                  if(groupValue == 'ByDate')
                                    _provider.searchAdvancedHall(context, {'keySearch':'ByDate', 'date':dateController.text.toString().trim(),}, EndPoint.searchHall);
                                  if(groupValue == 'ByPrice')
                                    _provider.searchAdvancedHall(context, {'keySearch':'ByPrice', 'price':priceController.text.toString().trim(),}, EndPoint.searchHall);
                                  if(groupValue == 'Nearest')
                                    _provider.searchAdvancedHall(context, {'keySearch':'Nearest'}, EndPoint.getAllHall);
                                } else {
                                  showToast(message: txt_notInternet, state: ToastStates.error);

                                }
                                }


                              },
                              margin: const EdgeInsets.all(0.0),
                              padding: const EdgeInsets.all(5.0),
                              width: _myWidth,
                              rediusCircular: 10,
                              bgColor: AppColor.PrimaryColor,
                              bgOverlayColor:Colors.white.withOpacity(0.8),
                              txtColor: Colors.white,
                              height: _myHeight * 0.09,
                              text: 'بحث',
                              textSize: _myWidth * 0.05,
                            ) ,
                            const SizedBox(height: 8,),
                          ],
                        ),

                      ),

                      const SizedBox(height: 10),
                      _provider.loading ?   SpinKitFadingCircle(
                        color: AppColor.PrimaryColor,
                        size: 45.0,
                      ) : Expanded(child: ListView.builder(

                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _provider.hallList.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(margin:EdgeInsets.symmetric(horizontal: 2,vertical: 1) ,
                              child: HallItem(
                              height: _myHeight,
                              width: _myWidth,
                              model:_provider.hallList[index] ,
                              index: index,
                            ) ,);
                          }
                      )),


                    ],
                  ),
                ),

            )
        ),
      ),
    );
  }


}





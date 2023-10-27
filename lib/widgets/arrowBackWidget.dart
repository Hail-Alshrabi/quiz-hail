
import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({Key? key ,required this.myContext}) : super(key: key);
  final BuildContext myContext;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(myContext),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 8.0,),
        margin: const EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0,right: 6.0,),
        decoration: BoxDecoration(
          color: AppColor.PrimaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.0),
        ) ,
        child: const Icon(Icons.arrow_back_ios ,color: Colors.white,size: 18.0,),
      ),
    );
  }
}

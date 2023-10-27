import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/colors_constants.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key,this.height = 200}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height,),
          SpinKitCircle(
            color:AppColor.PrimaryColor ,
            size: 60.0,
          ) ,
        ],
      ),
    );
  }
}

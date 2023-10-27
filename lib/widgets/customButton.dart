
import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 10.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 10.0),
    this.width = double.infinity,
     this.height = 70.0,
    this.bgColor = AppColor.PrimaryColor,
    this.bgOverlayColor = Colors.white70 ,
    this.rediusCircular = 15.0 ,
    this.borderColor = AppColor.PrimaryColor,
    this.textSize = 18.0 ,
    required this.text  ,
    this.txtColor = Colors.white ,
    this.iconPath,
    this.iconColor = Colors.white ,
    this.icon ,

  }) : super(key: key);

  final EdgeInsets padding;
  final EdgeInsets margin;
  final double width;
   final double height;
  final double textSize;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color bgOverlayColor;
  final double rediusCircular ;
  final Color borderColor;
  final String text ;
  final Color txtColor;
  final String? iconPath;
  final Color iconColor;
  final Icon? icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
       height: height, //width of button
      child:ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return bgOverlayColor; //<-- SEE HERE
              return null; // Defer to the widget's default.
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rediusCircular),
              side: BorderSide(width: 1, color: borderColor),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(text,textAlign: TextAlign.center,
              style:TextStyle(
                color: txtColor , fontSize: textSize,fontWeight: FontWeight.w200 ,
              ) ,), // <-- Text
            const SizedBox( width: 10.0,),
            iconPath !=null ?Image.asset(iconPath ?? '',color: iconColor,) : SizedBox(),
            icon != null ? icon! : SizedBox(),
          ],
        ),
      ),
    );
  }
}

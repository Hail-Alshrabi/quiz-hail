import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({Key? key,
    this.width =double.infinity,
    this.height,
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    required this.hint,
    this.hintColor =AppColor.GreyShade1 ,
    required this.textEditController,
    this.textAlign =TextAlign.start,
    this.textInputType = TextInputType.text,
    this.actionKeyboard = TextInputAction.next,
    this.validator = null,
    this.enableBorder = true,
    this.enableFocusedBorder = false,
    this.borderColor = AppColor.PrimaryColor,
    this.focuedborderColor = AppColor.PrimaryColor,
    this.cornerRadius = 15.0,
    this.maxLength = null,
    this.counterText = '' ,
    this.prefixIcon,
    this.suffixIcon,
    this.text_style ,
    this.readOnly =false,
    this.labelText,
    this.labelColor = AppColor.PrimaryColor,
    this.fillColor = Colors.white,
    this.filled = false,
    this.maxLines = 1,
    this.onTap ,

  }) : super(key: key);

  final bool hidePassword = true;


  final double width;
  final double? height;
  final EdgeInsets margin;
  final String hint;
  final Color hintColor;
  final TextAlign textAlign;
  final TextEditingController textEditController;
  final TextInputType textInputType;
  final TextInputAction actionKeyboard;
  final String? Function(String?)? validator;
  final bool enableBorder;
  final bool enableFocusedBorder;
  final Color borderColor;
  final Color focuedborderColor;
  final double cornerRadius;
  final int? maxLength;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextStyle? text_style;
  final String? labelText;
  final Color labelColor;
  final String? counterText;
  final Color fillColor;
  final bool filled;
  final bool readOnly;
  final int? maxLines;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
       height: height,
      margin: margin,
      child: TextFormField(
        maxLines: maxLines,
        controller: textEditController,
        validator: validator,
        keyboardType :textInputType,
        textInputAction:actionKeyboard,
        showCursor: true,
        cursorColor: AppColor.PrimaryColor,
        cursorHeight: 20.0,
        textAlign: textAlign ,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(

          fillColor: fillColor,
            filled: filled,
            hintText: hint as String,
            counterText: counterText,
            border: getBorder(),

            enabledBorder: enableBorder ? getBorder() : InputBorder.none,
            focusedBorder: enableFocusedBorder ? getfocusedBorder() : getBorder(),
            labelText: labelText ?? hint as String,
            labelStyle: TextStyle(color: labelColor , fontSize: 15.0,fontWeight: FontWeight.w500),


          prefixIcon: prefixIcon == null ? null:prefixIcon ,

          suffixIcon: suffixIcon,
          contentPadding:prefixIcon == null ? const EdgeInsets.only(right: 20.0,top: 10.0,bottom: 10.0) : const EdgeInsets.only(right: 1.0,top: 10.0,bottom: 10.0) ,
          hintStyle: TextStyle(
            color:hintColor,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),

        ),
        maxLength: maxLength,
        style:text_style ,

      ),
    );
  }

  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide(width: 1.0, color: borderColor),
      gapPadding: 3.0,
    );
  }

  OutlineInputBorder getfocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide(width: 1.0, color: focuedborderColor),
      gapPadding: 3.0,
    );
  }


}


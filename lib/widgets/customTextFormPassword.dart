import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

class CustomTextFormPassword extends StatefulWidget {
  const CustomTextFormPassword({Key? key,
    this.width =double.infinity,
    //this.height =50.0,
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
    this.labelText,
    this.labelColor = AppColor.PrimaryColor,
    this.fillColor = Colors.white,
    this.filled = false,
    this.maxLines = 1,

  }) : super(key: key);

  final double width;
  //final double height;
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
  final int? maxLines;

  @override
  State<CustomTextFormPassword> createState() => _CustomTextFormPasswordState();
}

class _CustomTextFormPasswordState extends State<CustomTextFormPassword> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: widget.height,
      margin: widget.margin,
      child: TextFormField(
        maxLines: widget.maxLines,
        controller: widget.textEditController,
        validator: widget.validator,
        obscureText: isPasswordField && hidePassword ,
        keyboardType :widget.textInputType,
        textInputAction: widget.actionKeyboard,
        showCursor: true,
        cursorColor: AppColor.PrimaryColor,
        cursorHeight: 20.0,
        textAlign: widget.textAlign ,

        decoration: InputDecoration(

          fillColor: widget.fillColor,
            filled: widget.filled,
            hintText: widget.hint as String,
            counterText: widget.counterText,
            border: getBorder(),

            enabledBorder: widget.enableBorder ? getBorder() : InputBorder.none,
            focusedBorder: widget.enableFocusedBorder ? getfocusedBorder() : getBorder(),
            labelText: widget.labelText ?? widget.hint as String,
            labelStyle: TextStyle(color: widget.labelColor , fontSize: 15.0,fontWeight: FontWeight.w500),


          prefixIcon: widget.prefixIcon == null ? null:widget.prefixIcon ,

          suffixIcon: getSuffixIcon(),
          contentPadding:widget.prefixIcon == null ? const EdgeInsets.only(right: 20.0,top: 10.0,bottom: 10.0) : const EdgeInsets.only(right: 1.0,top: 10.0,bottom: 10.0) ,
          hintStyle: TextStyle(
            color: widget.hintColor,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),

        ),
        maxLength: widget.maxLength,
        style:widget.text_style ,

      ),
    );
  }

  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.cornerRadius),
      borderSide: BorderSide(width: 1.0, color: widget.borderColor),
      gapPadding: 3.0,
    );
  }

  OutlineInputBorder getfocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.cornerRadius),
      borderSide: BorderSide(width: 1.0, color: widget.focuedborderColor),
      gapPadding: 3.0,
    );
  }

  Widget? getSuffixIcon() {
    if (isPasswordField) {
      return IconButton(
        onPressed: () {
          hidePassword = !hidePassword;
          setState(() {});
        },
        icon: Icon(
          hidePassword ? Icons.visibility_off : Icons.visibility,
          color: widget.borderColor ,
        ),
      );
    } else {
      return widget.suffixIcon;
    }
  }

  bool get isPasswordField => widget.textInputType == TextInputType.visiblePassword;
}


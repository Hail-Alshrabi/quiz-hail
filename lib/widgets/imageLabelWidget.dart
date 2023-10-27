import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors_constants.dart';



class ImageLabelWidget extends StatelessWidget {
  const ImageLabelWidget({Key? key, required this.file,required this.width,required this.height, this.label ='', required this.getImageFromGallery}) : super(key: key);
  final File? file;
  final double width;
  final double height;
  final String label;
  final VoidCallback getImageFromGallery;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getImageFromGallery ,
      child: Column(
        children: [
          Container(
            width: width,
            height:height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: AppColor.GreyShade3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: file != null ? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child:  Image.file(
                  file!,
                  fit: BoxFit.fill
              ),
            ) : Image.asset(AssetsPath.add_image,color: AppColor.GreyShade5,),
          ),

          Text(label,style: TextStyle(color: Colors.black,fontSize: 12,),),

        ]
        ,
      ),
    );
  }
}

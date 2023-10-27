import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';

TextStyle get white16 =>const TextStyle(
  color: Colors.white,fontSize: 16.0,
);

TextStyle get white16bold =>const TextStyle(
  color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,
);

TextStyle get white16W600 =>const TextStyle(
  color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.w600,
);

TextStyle get white24W500 =>const TextStyle(
  color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.w500,
);

TextStyle get black16 =>const TextStyle(
  color: Colors.black,fontSize: 16.0,
);
TextStyle get black14W500 =>const TextStyle(
  color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.w500,
);

TextStyle get black18W500 =>const TextStyle(
  color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w500,
);
TextStyle get primarycolor16W600 =>const TextStyle(
    fontSize: 16, color: AppColor.PrimaryColor,fontWeight: FontWeight.w600,
);
TextStyle get primarycolor14 =>const TextStyle(
  fontSize: 14, color: AppColor.PrimaryColor,
);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/const/app_colors.dart';

class AppStyles {
  static InputDecoration textFieldDecoration(String hint) => InputDecoration(
    border: OutlineInputBorder(
      borderRadius:BorderRadius.circular(10.r),
    ),
    hintText: hint,

  );

  static TextStyle mySmallTextStyle = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w300,
      );

  static TextStyle myTextStyle = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w200,);

  static TextStyle BlackTextStyle = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w300,);

  static TextStyle smallTextStyle = TextStyle(
      fontSize: 14.sp,
      
      fontWeight: FontWeight.w300,
     );

  progressDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            "assets/files/loading.gif",
            height: 150.h,
          ),
        );
      },
      barrierDismissible: false,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/const/app_colors.dart';



Widget customButton(
  String title,
  onPressed,
) {
  return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: AppColors.blueAccent,
          child: InkWell(
            onTap: onPressed,
            splashColor: Colors.white,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )));
}

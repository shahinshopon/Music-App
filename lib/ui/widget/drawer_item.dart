

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/ui/styles/styles.dart';

Widget drawerItem(icon,title,onAction){
  RxBool _value = false.obs;
  return Padding(
    padding:  EdgeInsets.only(bottom: 20.h),
    child: InkWell(
      onTap: (){
        _value.value = true;
        onAction();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color:AppColors.whiteColor,
            size: 20.w,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            title,
            style: AppStyles.myTextStyle
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    ),
  );
}
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/route/route.dart';
import 'package:music_app/ui/styles/styles.dart';

import '../widget/music_auth_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  Future chooseScreen() async {
    var userId = box.read('uid');
    if (userId == null) {
      Get.toNamed(login);
    } else {
      Get.toNamed(home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: ScreenUtil().screenWidth,
          child: Padding(
            padding: EdgeInsets.only(
                top: 60.h, right: 40.w, left: 40.w, bottom: 50.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppString.musicHouse,
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Image.asset(
                  "assets/images/itunes.png",
                  width: 150.w,
                ),
                Text(
                  AppString.enjoyUnlimited,
                  textAlign: TextAlign.center,
                  style: AppStyles.mySmallTextStyle,
                ),
                customButton(
                  "Get Started",
                  () => chooseScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/theme/app_theme.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  RxBool? darkMode = false.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
      
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          AppString.setting,
          style: AppStyles.BlackTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              child: ListTile(
                title: Text("Brightness"),
                trailing: Obx(
                  () => Switch(
                    value: darkMode!.value,
                    onChanged: (bool value) {
                      darkMode!.value = value;
                      Get.changeTheme(
                        darkMode!.value == false
                            ? AppTheme().lightTheme(context)
                            : AppTheme().darkTheme(context),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

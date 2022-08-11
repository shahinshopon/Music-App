// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_app/business_logics/helper/auth_helper.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/music_auth_button.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h, right: 20.w, left: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Image.asset(
                    "assets/images/itunes.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.forgotPassword,
                        style: AppStyles.BlackTextStyle,
                      )),
                  SizedBox(
                    height: 40.h,
                  ),
                  FromField(
                    _emailController,
                    TextInputType.emailAddress,
                    AppString.emailAddress,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      } else if (!value.contains(RegExp(r'\@'))) {
                        return "enter a valid email address";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  customButton(AppString.submit, () async {
                    if (_formkey.currentState!.validate()) {
                     AuthHelper().resetPassword(_emailController, context);
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

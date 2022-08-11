// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/route/route.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/music_auth_button.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

import '../../../business_logics/helper/auth_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 35.w, right: 35.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/itunes.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  FromField(
                    _emailController,
                    TextInputType.name,
                    "Email",
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
                    height: 25.h,
                  ),
                  FromField(
                    _passwordController,
                    TextInputType.text,
                    AppString.password,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      } else if (value.length < 6) {
                        return "password at least 6 digit";
                      } else if (value.length > 10) {
                        return "password must be 6-10 digit";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(forgetPassword),
                    child: Text(
                      AppString.forgetPassword,
                      style: AppStyles.mySmallTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  customButton(AppString.login, () {
                    if (_formkey.currentState!.validate()) {
                      AuthHelper().login(_emailController.text,
                          _passwordController.text, context);
                    }
                  }),
                  SizedBox(
                    height: 15.h,
                  ),
                  RichText(
                      text: TextSpan(
                          text: AppString.doNotAccount,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.blue,

                          ),
                          children: [
                        TextSpan(
                          text: AppString.signUp,
                          style:TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.amberAccent,
                            
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(signUp),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

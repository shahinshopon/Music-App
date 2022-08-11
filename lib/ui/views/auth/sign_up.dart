// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/route/route.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/music_auth_button.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _userNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _numberController = TextEditingController();

  XFile? image;

  pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {});
  }

  uploadImageToStroage(context) async {
    try {
      AppStyles().progressDialog(context);
      File imageFile = File(image!.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadTask = storage
          .ref('users-profile-images')
          .child(image!.name)
          .putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      registration(imageUrl);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      Get.back();
    }
  }

  registration(imageUrl) async {
    final box = GetStorage();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        CollectionReference registerData =
            FirebaseFirestore.instance.collection("registration");
        registerData
            .doc(_emailController.text)
            .set({
              "email": _emailController.text,
              "user_name": _userNameController.text,
              "password": _passwordController.text,
              "mobile": _numberController.text,
              "profile": imageUrl,
            })
            .whenComplete(() => box.write('uid', authCredential.uid).then(
                  (value) => Fluttertoast.showToast(
                      msg: "Registration Successful",
                      backgroundColor: Colors.black87),
                ))
            .then((value) => Get.toNamed(home));
      } else {
        Fluttertoast.showToast(
            msg: "SignUp failed", backgroundColor: Colors.black87);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "Password is too week", backgroundColor: Colors.black87);
        Get.back();
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            backgroundColor: Colors.black87);
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error is:$e", backgroundColor: Colors.black87);
      Get.back();
    }
  }

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
          padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppString.newAccount,
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          child: Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.r),
                              ),
                            ),
                            child: image == null
                                ? Icon(
                                    Icons.person_outlined,
                                    size: 40.w,
                                    color: Colors.black54,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.r),
                                    ),
                                    child: Image.file(
                                      File(image!.path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.r),
                            ),
                          ),
                          elevation: 5,
                        ),
                        Positioned(
                          bottom: -10,
                          child: InkWell(
                            onTap: () => pickGalleryImage(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.r),
                            ),
                            child: CircleAvatar(
                              backgroundColor: AppColors.blueAccent,
                              radius: 20.r,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 18.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppString.enterEmail,
                    style: AppStyles.mySmallTextStyle,
                  ),
                  SizedBox(
                    height: 10.h,
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
                    height: 10.h,
                  ),
                  Text(
                    AppString.enterUserName,
                    style: AppStyles.mySmallTextStyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FromField(
                    _userNameController,
                    TextInputType.text,
                    AppString.userName,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      } else if (value.length < 4) {
                        return "user name must more than 4 alphabet.";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppString.enterYourPassword,
                    style: AppStyles.mySmallTextStyle,
                  ),
                  SizedBox(
                    height: 10.h,
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
                    height: 10.h,
                  ),
                  Text(
                    AppString.confirmPassword,
                    style: AppStyles.mySmallTextStyle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FromField(
                    _numberController,
                    TextInputType.number,
                    AppString.mobileNumberText,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "this field can't be empty";
                      } else if (value.length < 11) {
                        return "write a valid number";
                      } else if (value.length > 11) {
                        return "Can't be more than 11 digit.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  customButton(
                    AppString.signUp,
                    () {
                      if (image == null) {
                        Fluttertoast.showToast(msg: "Please select an image");
                      } else if (_formkey.currentState!.validate() &&
                          image != null) {
                        uploadImageToStroage(context);
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(
                            text: AppString.doNotAccount,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue,
                            ),
                            children: [
                          TextSpan(
                            text: AppString.signIn,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.amberAccent,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(login),
                          ),
                        ])),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

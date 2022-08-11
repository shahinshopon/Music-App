// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/music_auth_button.dart';

import '../../widget/text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? image;
  TextEditingController _emailController = TextEditingController();

  TextEditingController _userNameController = TextEditingController();

  TextEditingController _numberController = TextEditingController();
  pickGalleryImage() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  final _formkey = GlobalKey<FormState>();

  uploadImageToStroage(context, data) async {
    if (image == null) {
      update(null, data);
    } else {
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
        update(imageUrl, data);
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        Get.back();
      }
    }
  }

  update(imageUrl, data) async {
    try {
      AppStyles().progressDialog(context);
      CollectionReference registerData =
          FirebaseFirestore.instance.collection("registration");
      registerData
          .doc(_emailController.text)
          .update({
            "email": _emailController.text,
            "user_name": _userNameController.text,
            "mobile": _numberController.text,
            "profile": imageUrl ?? data['profile'],
          })
          .then(
            (value) => Fluttertoast.showToast(
                msg: "Updated Successfully", backgroundColor: Colors.black87),
          )
          .then(
            (value) => Get.back(),
          );
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something is wrong", backgroundColor: Colors.black87);
      Get.back();
    }
  }

  setDataToField(data) {
    _emailController.text = data['email'];
    _userNameController.text = data['user_name'];
    _numberController.text = data['mobile'];

    return Padding(
      padding: EdgeInsets.only(top: 50.h, left: 25.w, right: 25.w),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.r),
                        ),
                      ),
                      elevation: 5,
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.r),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.r),
                          ),
                          child: image == null
                              ? Image.network(
                                  data['profile'],
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(image!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
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
                readOnly: true,
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
                "Phone",
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
                "Update",
                () {
                  if (_formkey.currentState!.validate()) {
                    uploadImageToStroage(context, data);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile",),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("registration")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return setDataToField(data);
          }
        },
      ),
    );
  }
}

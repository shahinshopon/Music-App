import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../ui/route/route.dart';
import '../../ui/styles/styles.dart';

class AuthHelper {
  final box = GetStorage();
  Future login(String emailAddress, String password, context) async {
    try {
      AppStyles().progressDialog(context);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        await box.write('uid', authCredential.uid);
        Fluttertoast.showToast(msg: 'Login Successfull');
        Get.toNamed(home);
      } else {
        Fluttertoast.showToast(
            msg: "Something is wrong", backgroundColor: Colors.black87);
            Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
        Get.back();
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
      Get.back();
    }
  }

  Future registration(String emailAddress, String password, context) async {
    try {
      AppStyles().progressDialog(context);
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        box
            .write('uid', authCredential.uid)
            .then(
              (value) => Fluttertoast.showToast(
                  msg: "Registration Successful",
                  backgroundColor: Colors.black87),
            )
            .then((value) => Get.toNamed(home));
      } else {
        Fluttertoast.showToast(
            msg: "SignUp failed", backgroundColor: Colors.black87);
            Get.back();
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

  Future resetPassword(resetEmailController, context) async {
    try {
      AppStyles().progressDialog(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: resetEmailController.text.trim(),
      );
      Fluttertoast.showToast(
          msg:
              'email has been sent to ${resetEmailController.text} to reset your password.');
      Get.back();
    } on FirebaseAuthException catch (e) {
    Get.back();
      Fluttertoast.showToast(msg: '${e.message}');
    }
  }
}

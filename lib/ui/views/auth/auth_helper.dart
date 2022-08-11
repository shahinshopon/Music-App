// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/auth/phone_number.dart';
import 'package:music_app/ui/views/auth/verification.dart';

class AuthHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  String verId = '';
   
  phoneAuth(number, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // UserCredential _userCredential =
        //     await auth.signInWithCredential(credential);
        // User? _user = _userCredential.user;
        // if (_user!.uid.isNotEmpty) {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => PhoneNumber()));
        // } else {
        //   print("Failed");
        // }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verId = verificationId;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Verification(verId)));

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter Your OTP"),
                content: Column(
                  children: [
                    TextField(
                      controller: otpController,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          PhoneAuthCredential phonecredential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: otpController.text);
                          UserCredential _userCredential =
                              await auth.signInWithCredential(phonecredential);
                          User? _user = _userCredential.user;
                          if (_user!.uid.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneNumber()));
                          } else {
                            print("Failed");
                          }
                        },
                        child: Text("Continue"))
                  ],
                ),
              );
            });
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

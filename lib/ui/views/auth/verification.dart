import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/auth/phone_number.dart';

class Verification extends StatefulWidget {
   var verificationId;
   Verification(this.verificationId);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: otpController,
          ),
          ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential phonecredential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otpController.text);
                UserCredential _userCredential =
                    await auth.signInWithCredential(phonecredential);
                User? _user = _userCredential.user;
                if (_user!.uid.isNotEmpty) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhoneNumber()));
                } else {
                  print("Failed");
                }
              },
              child: Text("Continue")),
        ],
      ),
    );
  }
}

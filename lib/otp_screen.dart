import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_otp_authentication/main.dart';

class OTPScreen extends StatefulWidget {
  String verificationid;
  //final String verificationid;
  OTPScreen({super.key, required this.verificationid});
  //OTPScreen({Key? key, required this.verificationid}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter the Otp",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: otpController.text.toString());
                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "My Home Page")));
                });
              } catch (ex) {
                debugPrint(ex.toString());
              }
            },
            child: Text("OTP"),
          )
        ],
      ),
    );
  }
}

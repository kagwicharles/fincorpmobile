import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/loginscreen.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class OTPScreen extends StatefulWidget {
  final String mobilenumber;

  const OTPScreen({super.key, required this.mobilenumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _authapi = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fincorp"),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _otpcontroller,
                      decoration: const InputDecoration(labelText: "OTP"),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Enter OTP";
                        }
                      },
                    ),
                    mhGap(),
                    ElevatedButton(
                        onPressed: verifyotp, child: const Text("Verify"))
                  ],
                ))));
  }

  verifyotp() {
    if (_formkey.currentState!.validate()) {
      _authapi
          .verifyOTP(
              mobileNumber: widget.mobilenumber, otp: _otpcontroller.text)
          .then((value) {
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(const LoginScreen());
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

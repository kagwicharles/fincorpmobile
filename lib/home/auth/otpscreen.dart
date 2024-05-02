import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/loginscreen.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

import '../../theme/apptheme.dart';

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

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    "Verify OTP",
                    style: TextStyle(
                        fontSize: 40,
                        color: AppTheme.secondaryAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  hGap(),
                  const Text(
                    "Enter OTP sent to your email/sms to verify details",
                    style: TextStyle(color: Colors.white),
                  ),
                  mhGap(),
                  Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppTheme.secondaryAccent)),
                              onPressed: verifyotp,
                              child: isloading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Verify OTP")),
                        ],
                      ))
                ],
              )),
          backgroundColor: const Color(0xff111111),
        ));
  }

  verifyotp() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      _authapi
          .verifyOTP(
              mobileNumber: widget.mobilenumber, otp: _otpcontroller.text)
          .then((value) {
        setState(() {
          isloading = false;
        });
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(const LoginScreen());
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

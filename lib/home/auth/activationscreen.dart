import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/otpscreen.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final _phonecontroller = TextEditingController();
  final _pincontroller = TextEditingController();
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
                      controller: _phonecontroller,
                      decoration: const InputDecoration(labelText: "Phone"),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Enter phone";
                        }
                      },
                    ),
                    hGap(),
                    TextFormField(
                      obscureText: true,
                      controller: _pincontroller,
                      decoration: const InputDecoration(labelText: "PIN"),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Enter PIN";
                        }
                      },
                    ),
                    mhGap(),
                    ElevatedButton(
                        onPressed: activateuser, child: const Text("Login"))
                  ],
                ))));
  }

  activateuser() {
    if (_formkey.currentState!.validate()) {
      _authapi
          .activate(
              mobileNumber: _phonecontroller.text, pin: _pincontroller.text)
          .then((value) {
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(OTPScreen(
            mobilenumber: _phonecontroller.text,
          ));
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

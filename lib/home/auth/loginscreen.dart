import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../dashboardscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      controller: _pincontroller,
                      decoration: const InputDecoration(labelText: "PIN"),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Enter PIN";
                        }
                      },
                    ),
                    mhGap(),
                    ElevatedButton(onPressed: login, child: const Text("Login"))
                  ],
                ))));
  }

  login() {
    if (_formkey.currentState!.validate()) {
      _authapi.login(_pincontroller.text).then((value) {
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(DashboardScreen());
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

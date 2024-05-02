import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/theme/apptheme.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    "Login",
                    style: TextStyle(
                        fontSize: 40,
                        color: AppTheme.secondaryAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  hGap(),
                  const Text(
                    "Login to the app to access all the mobile application's features",
                    style: TextStyle(color: Colors.white),
                  ),
                  mhGap(),
                  Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppTheme.secondaryAccent)),
                              onPressed: login,
                              child: const Text("Login")),
                          mhGap(),
                          Text(
                            "or Login Using Biometrics",
                            style: TextStyle(color: Color(0xff808080)),
                          ),
                          hGap(),
                          Center(
                              child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.fingerprint_outlined,
                                color: AppTheme.secondaryAccent,
                                size: 34,
                              ),
                            ),
                          )),
                          hGap(),
                          Center(
                            child: Text(
                              "Fingerprint",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ))
                ],
              )),
          backgroundColor: const Color(0xff111111),
        ));
  }

  login() {
    if (_formkey.currentState!.validate()) {
      _authapi.login(_pincontroller.text).then((value) {
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(const DashboardScreen());
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/activationscreen.dart';
import 'package:fincorpmobile/home/auth/loginscreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _pref = CommonSharedPref();
  bool isactivated = false;

  @override
  void initState() {
    super.initState();
    checkactivationstatus();
  }

  checkactivationstatus() async {
    var status = await _pref.getAppActivationStatus();
    setState(() {
      isactivated = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dash"),
        ),
        body: Center(
            child: SizedBox(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      if (isactivated) {
                        context.navigate(const LoginScreen());
                      } else {
                        context.navigate(const ActivationScreen());
                      }
                    },
                    child: const Text("Login")))));
  }
}

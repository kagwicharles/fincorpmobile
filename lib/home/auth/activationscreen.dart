import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/otpscreen.dart';
import 'package:fincorpmobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:vibration/vibration.dart';

import '../../theme/apptheme.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final _phonecontroller = TextEditingController();
  final _pincontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  PhoneNumber inputNumber = PhoneNumber(isoCode: APIService.countryIsoCode);

  final _authapi = AuthRepository();
  bool _isloading = false;

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
                    "Activate App",
                    style: TextStyle(
                        fontSize: 40,
                        color: AppTheme.secondaryAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  hGap(),
                  const Text(
                    "Enter details below to receive OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                  mhGap(),
                  Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InternationalPhoneNumberInput(
                            maxLength: 10,
                            onInputChanged: (PhoneNumber number) {
                              inputNumber = number;
                            },
                            selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.DIALOG,
                                setSelectorButtonAsPrefixIcon: true,
                                leadingPadding: 14),
                            inputDecoration: const InputDecoration(
                              labelText: "Mobile Number",
                            ),
                            countries: const ["SZ"],
                            validator: (value) {
                              debugPrint("length--->${value?.length}");
                              if (value?.length != 10) {
                                return "Invalid mobile number";
                              }
                            },
                          ),
                          hGap(),
                          TextFormField(
                            keyboardType: TextInputType.number,
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
                              onPressed: activateuser,
                              child: _isloading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Activate")),
                        ],
                      ))
                ],
              )),
          backgroundColor: const Color(0xff111111),
        ));
  }

  activateuser() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      var mobileno =
          inputNumber.phoneNumber?.replaceAll("+", "").replaceAll(" ", "");
      _authapi
          .activate(mobileNumber: mobileno, pin: _pincontroller.text)
          .then((value) {
        setState(() {
          _isloading = false;
        });
        if (value.status == StatusCode.success.statusCode) {
          context.navigate(OTPScreen(
            mobilenumber: mobileno ?? "",
          ));
        }
      });
    } else {
      Vibration.vibrate();
    }
  }
}

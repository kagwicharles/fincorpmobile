import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:fincorpmobile/home/auth/loginscreen.dart';
import 'package:fincorpmobile/home/dashboardscreen.dart';
import 'package:fincorpmobile/home/loadingscreen.dart';
import 'package:flutter/material.dart';

import 'theme/apptheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DynamicCraftWrapper(
    dashboard: const DashboardScreen(),
    appLoadingScreen: const LoadingScreen(),
    appTimeoutScreen: const LoginScreen(),
    appInactivityScreen: const LoginScreen(),
    appTheme: AppTheme().appTheme,
    useExternalBankID: true,
    showAccountBalanceInDropdowns: true,
  ));
}

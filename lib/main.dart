import 'package:dalil/screens/ResetPasswordScreen.dart';
import 'package:dalil/screens/VerificationCodeScreen.dart';
import 'package:flutter/material.dart';
import 'screens/VerificationCodeScreen.dart';
import 'core/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalil Metro',
      theme: AppTheme.lightTheme,
      home: VerificationCodeScreen(email: '',),
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:dalil/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that plugin services are initialized so that Firebase can be used
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalil Metro',
      theme: AppTheme.lightTheme,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
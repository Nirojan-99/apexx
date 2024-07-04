import 'package:apexx/Screen/Account.dart';
import 'package:apexx/Screen/Login.dart';
import 'package:apexx/Screen/Register.dart';
import 'package:flutter/material.dart';
import 'Theme/Custom_dark_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apexx',
      theme: customDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/account": (context) => const AccountScreen(),
      },
    );
  }
}

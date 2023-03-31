import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/pages/gallaryPage.dart';
import 'package:http/http.dart' as http;
import 'package:test/pages/welcomePage.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginApp(),
    );
  }
}

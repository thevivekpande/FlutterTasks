import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (BuildContext context) => LoginApp(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [secondaryColor, primaryColor],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

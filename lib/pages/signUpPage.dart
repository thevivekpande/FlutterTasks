import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test/pages/SignUpSecondPage.dart';
import 'package:test/pages/SignupFirstPage.dart';
import 'package:test/utils/colors.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../utils/globalMethods.dart';
import 'ButtonWidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _currentStep = 1;

  int get currentStep => _currentStep;

  updateCurrentStep() {
    setState(() {
      _currentStep = 2;
    });
  }

  void updateStep() {
    setState(() {
      _currentStep = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: 25,
              right: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _currentStep == 1
                      ? () => Navigator.pop(context)
                      : () {
                          setState(() {
                            _currentStep = 1;
                          });
                        },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 65,
                ),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                StepProgressIndicator(
                  size: 4,
                  totalSteps: 2,
                  currentStep: currentStep,
                  selectedColor: Colors.white,
                  unselectedColor: secondaryColor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 60,
              left: 30,
              right: 30,
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            width: double.infinity,
            child: _currentStep == 1
                ? SignupFirstPage(isUpdated: (isUpdated) => updateStep())
                : SignUpSecondPage(),
          ),
        ],
      ),
    );
  }
}

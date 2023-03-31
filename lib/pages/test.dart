import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test/utils/colors.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'ButtonWidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _currentStep = 1;
  String _gender = "male";
  String _chosenValue = 'Once a week';

  var _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _emailFilled = false;
  bool _isNextButtonDisabled = true;
  bool _isObscurePass = true;
  bool _isObscureConfirmPass = true;
  String _passWord = '';
  String _confirmPassWord = '';
  bool _isPassEquals = false;
  bool _isMinLen = false;
  bool _isUpperCase = false;
  bool _isNumber = false;
  bool _isLowerCase = false;

  @override
  void initState() {
    super.initState();
    _isNextButtonDisabled = true;
  }

  void setGender(value) {
    setState(() {
      _gender = value;
    });
  }

  void setChosenValue(value) {
    setState(() {
      _chosenValue = value;
    });
  }

  void setEmail(value) {
    if (value.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      setState(() {
        _emailFilled = false;
      });
    } else {
      setState(() {
        _email = value;
        _emailFilled = true;
        _isNextButtonDisabled = false;
      });
    }
  }

  void validatePassword(value) {
    setState(() {
      _passWord = value;
    });

    // validate for min length
    if (value.toString().length >= 8) {
      setState(() {
        _isMinLen = true;
      });
    } else {
      setState(() {
        _isMinLen = false;
      });
    }

    // validate for capital letter
    if (value.toString().contains(RegExp(r'[A-Z]'))) {
      setState(() {
        _isUpperCase = true;
      });
    } else {
      setState(() {
        _isUpperCase = false;
      });
    }

    // validate for lower case letter
    if (value.toString().contains(RegExp(r'[a-z]'))) {
      setState(() {
        _isLowerCase = true;
      });
    } else {
      setState(() {
        _isLowerCase = false;
      });
    }

    // validate for a number
    if (value.toString().contains(RegExp(r'[0-9]'))) {
      setState(() {
        _isNumber = true;
      });
    } else {
      setState(() {
        _isNumber = false;
      });
    }

    // validate for equal password
    if (_confirmPassWord == _passWord && _passWord != '') {
      setState(() {
        _isPassEquals = true;
      });
    } else {
      setState(() {
        _isPassEquals = false;
      });
    }
  }

  void validateConfirmPassword(value) {
    setState(() {
      _confirmPassWord = value;
    });

    // validate for equal password
    if (_confirmPassWord == _passWord && _passWord != '') {
      setState(() {
        _isPassEquals = true;
      });
    } else {
      setState(() {
        _isPassEquals = false;
      });
    }
  }

  void onNextClick() {
    if (_emailFilled) {
      print("Validated.");
      setState(() {
        _currentStep = 2;
      });
    }
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
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                  currentStep: _currentStep,
                  selectedColor: Colors.white,
                  unselectedColor: secondaryColor,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            child: _currentStep == 1 ? FirstPage() : SecondPage(),
          ),
        ],
      ),
    );
  }

  Column SecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                hintText: 'Password',
                suffixIcon: IconButton(
                    icon: Icon(_isObscurePass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscurePass = !_isObscurePass;
                      });
                    }),
              ),
              onChanged: validatePassword,
              obscureText: _isObscurePass,
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                hintText: 'Confim Password',
                suffixIcon: IconButton(
                    icon: Icon(_isObscureConfirmPass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscureConfirmPass = !_isObscureConfirmPass;
                      });
                    }),
              ),
              keyboardType: TextInputType.visiblePassword,
              onChanged: validateConfirmPassword,
              obscureText: _isObscureConfirmPass,
            ),
            SizedBox(
              height: 12,
            ),
            errorMessage(_isMinLen, ' Minimum of 8 Characters'),
            errorMessage(_isUpperCase, ' A capital letter'),
            errorMessage(_isLowerCase, ' A lowercase letter'),
            errorMessage(_isNumber, ' A number'),
            errorMessage(_isPassEquals, ' Both boxes match'),
          ],
        ),
        Column(
          children: [
            ButtonWidget(
              color: primaryColor,
              onPressed: onNextClick,
              title: 'SIGN UP',
              width: 400,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ],
    );
  }

  Column FirstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s your email address?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                hintText: 'email',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: setEmail,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'What\'s your gender?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTileMethod("Male", "male"),
                ),
                Expanded(
                  child: ListTileMethod("Female", "female"),
                ),
                Expanded(child: ListTileMethod("N/A", "na")),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'How much do you train?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 173, 166, 166)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton(
                isExpanded: true,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                items: <String>[
                  'Once a week',
                  'Twice a week',
                  'Thrice a week',
                  'Daily',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: setChosenValue,
                value: _chosenValue,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            errorMessage(_emailFilled, ' Valid Email')
          ],
        ),
        Column(children: [
          ButtonWidget(
            color: primaryColor,
            onPressed: _isNextButtonDisabled ? () {} : onNextClick,
            title: 'NEXT',
            width: 400,
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ],
    );
  }

  Row errorMessage(bool isTrue, String message) {
    return Row(
      children: [
        Container(
          child: Icon(
            isTrue ? Icons.check : Icons.close,
            color: isTrue ? Colors.green : Colors.red,
          ),
        ),
        Container(
          child: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isTrue ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  ListTile ListTileMethod(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(title),
      leading: Radio(
        value: value,
        groupValue: _gender,
        onChanged: setGender,
      ),
    );
  }
}

class FirstStep extends StatelessWidget {
  const FirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'What\'s your email address?',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SecondStep extends StatelessWidget {
  const SecondStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test/pages/login.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../utils/colors.dart';
import '../utils/globalMethods.dart';
import 'ButtonWidget.dart';

class SignUpSecondPage extends StatefulWidget {
  const SignUpSecondPage({super.key});

  @override
  State<SignUpSecondPage> createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  var _formKey = GlobalKey<FormState>();
  bool _isObscurePass = true;
  bool _isObscureConfirmPass = true;
  String _passWord = '';
  String _confirmPassWord = '';
  bool _isPassEquals = false;
  bool _isMinLen = false;
  bool _isUpperCase = false;
  bool _isNumber = false;
  bool _isLowerCase = false;

  void validatePassword(value) {
    setState(() {
      _passWord = value;
    });

    bool isPassEqualFlag = false;
    bool isMinLenFlag = false;
    bool isNumberFlag = false;
    bool isLowerCaseFlag = false;
    bool isUpperCaseFlag = false;

    // validate for min length
    if (value.toString().length >= 8) {
      isMinLenFlag = true;
    }

    // validate for capital letter
    if (value.toString().contains(RegExp(r'[A-Z]'))) {
      isUpperCaseFlag = true;
    }

    // validate for lower case letter
    if (value.toString().contains(RegExp(r'[a-z]'))) {
      isLowerCaseFlag = true;
    }

    // validate for a number
    if (value.toString().contains(RegExp(r'[0-9]'))) {
      isNumberFlag = true;
    }

    // validate for equal password
    if (_confirmPassWord == _passWord && _passWord != '') {
      isPassEqualFlag = true;
    }

    setState(() {
      _isPassEquals = isPassEqualFlag;
      _isMinLen = isMinLenFlag;
      _isLowerCase = isLowerCaseFlag;
      _isUpperCase = isUpperCaseFlag;
      _isNumber = isNumberFlag;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SecondPage(),
    );
  }

  Column SecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: _formKey,
          child: Column(
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
              TextFormField(
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.required('Please enter password.'),
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.required('Please enter password.'),
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
        ),
        Column(
          children: [
            ButtonWidget(
              color: primaryColor,
              onPressed: () => () {},
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
}

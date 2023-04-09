import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/blocs/bloc/login_bloc.dart';
import 'package:test/modals/User.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../utils/colors.dart';
import '../utils/globalMethods.dart';
import 'ButtonWidget.dart';

class SignUpSecondPage extends StatefulWidget {
  final User user;
  final Function(bool) isSignedUp;

  const SignUpSecondPage({
    super.key,
    required this.user,
    required this.isSignedUp,
  });

  @override
  State<SignUpSecondPage> createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  var _formKey = GlobalKey<FormState>();
  bool _isObscurePass = true;
  bool _isObscureConfirmPass = true;
  bool _isPassEquals = false;
  bool _isMinLen = false;
  bool _isUpperCase = false;
  bool _isNumber = false;
  bool _isLowerCase = false;
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    validatePassword(widget.user.password);
    validateConfirmPassword(_confirmPassword);
  }

  void validatePassword(value) {
    setState(() {
      widget.user.password = value;
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
    if (_confirmPassword == widget.user.password &&
        widget.user.password != '') {
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
      _confirmPassword = value;
    });

    // validate for equal password
    if (_confirmPassword == widget.user.password &&
        widget.user.password != '') {
      setState(() {
        _isPassEquals = true;
      });
    } else {
      setState(() {
        _isPassEquals = false;
      });
    }
  }

  void onSignedUp() {
    widget.isSignedUp(true);
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
                initialValue: widget.user.password,
                obscureText: _isObscurePass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.compose([
                  Validators.required('Required field'),
                  Validators.minLength(8, 'Minimum of 8 Characters'),
                  Validators.patternRegExp(
                      RegExp(r'[A-Z]'), "A capital letter"),
                  Validators.patternRegExp(
                      RegExp(r'[a-z]'), "A lowercase letter"),
                  Validators.patternRegExp(RegExp(r'[0-9]'), "A number"),
                  Validators.patternString(
                      "${_confirmPassword}", "Both boxes match"),
                ]),
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
                onChanged: validateConfirmPassword,
                initialValue: _confirmPassword,
                obscureText: _isObscureConfirmPass,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.patternString(
                    "${widget.user.password}", "Both boxes match"),
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
            Center(
              child: ButtonWidget(
                color: primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<LoginBloc>().add(AddUser(user: widget.user));
                    onSignedUp();
                  }
                },
                title: 'SIGN UP',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
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

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


/*
import 'package:flutter/material.dart';
import 'package:test/utils/globalMethods.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

void main() {
  runApp(MyApp());
}

class User {
  String email;
  String gender;
  String password;
  User({this.email = '', this.gender = '', this.password = ''});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentPage = 0;
  User _user = User();

  void _saveEmailAndGender(String email, String gender) {
    setState(() {
      _user.email = email;
      _user.gender = gender;
      _currentPage++;
    });
  }

  void _savePassword(String password) {
    setState(() {
      _user.password = password;
    });
  }

  void _goBack() {
    setState(() {
      _currentPage--;
    });
  }

  Widget _buildEmailAndGenderPage() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: Validators.email('Please enter valid email.'),
            onSaved: (value) {
              setState(() {
                _user.email = value!;
              });
            },
            autovalidateMode: AutovalidateMode.always,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Gender'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Male'),
              Radio(
                value: 'Male',
                groupValue: _user.gender,
                onChanged: (value) {
                  setState(() {
                    _user.gender = value!;
                  });
                },
              ),
              Text('Female'),
              Radio(
                value: 'FeMale',
                groupValue: _user.gender,
                onChanged: (value) {
                  setState(() {
                    _user.gender = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _saveEmailAndGender(_user.email, _user.gender);
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordPage() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: Validators.required('Please enter valid password.'),
            onSaved: (value) {
              setState(() {
                _user.email = value!;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _goBack();
                },
                child: Text('Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _savePassword(_user.password);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    switch (_currentPage) {
      case 0:
        return Scaffold(body: _buildEmailAndGenderPage());
      default:
        return Scaffold(body: _buildPasswordPage());
    }
  }
}
*/



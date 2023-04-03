import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/pages/gallaryPage.dart';
import 'package:test/pages/signUpPage.dart';
import 'package:test/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'ButtonWidget.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();

  bool _isObscurePass = true;
  String _password = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
  }

  void onPressed(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _launchURLApp(BuildContext context, String url) async {
    var _url = Uri.parse(url);
    try {
      await launchUrl(_url);
    } catch (err) {
      onPressed(context, err.toString());
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final shavedEmail = sharedPreferences.getString('email');
      final shavedPassword = sharedPreferences.getString('password');
      if (shavedEmail == _email && shavedPassword == _password) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => GallaryPage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Incorrect email or password'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.18,
              left: 25.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                topLeft: Radius.circular(50.0),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: 50.0,
                    right: 50.0,
                    bottom: MediaQuery.of(context).size.height * 0.04,
                  ),
                  decoration: BoxDecoration(
                      boxShadow: kElevationToShadow[4],
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero,
                              ),
                            ),
                            hintText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            setState(() {
                              _email = value!;
                            });
                          },
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose([
                            Validators.required('Email is required'),
                            Validators.email('Enter valid email'),
                          ]),
                          initialValue: _email,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                            )),
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
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          initialValue: _password,
                          obscureText: _isObscurePass,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: Validators.compose([
                            Validators.required('Required field'),
                            Validators.minLength(8, 'Minimum of 8 Characters'),
                            Validators.patternRegExp(
                                RegExp(r'[A-Z]'), "A capital letter"),
                            Validators.patternRegExp(
                                RegExp(r'[a-z]'), "A lowercase letter"),
                            Validators.patternRegExp(
                                RegExp(r'[0-9]'), "A number"),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                      child: TextWidget(
                    title: 'Forgot Password ?',
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Center(
                      child: ButtonWidget(
                    title: 'Login',
                    color: primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _login();
                      }
                    },
                    width: MediaQuery.of(context).size.width * 0.5,
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Center(
                    child: TextWidget(title: 'Continue with social media'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        title: 'Facebook',
                        color: facebookColor,
                        onPressed: () => _launchURLApp(
                            context, 'https://www.facebook.com/login.php'),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      ButtonWidget(
                        title: 'Github',
                        color: githubColor,
                        onPressed: () => _launchURLApp(
                            context, 'https://www.github.com/login'),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: const Text('Don\'t have an account? '),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpPage())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: const Text(
                            'Sign up.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String title;
  const TextWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

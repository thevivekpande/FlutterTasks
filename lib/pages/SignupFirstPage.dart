import 'package:flutter/material.dart';
import 'package:test/modals/User.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../utils/colors.dart';
import 'ButtonWidget.dart';

class SignupFirstPage extends StatefulWidget {
  final Function(bool) isUpdated;
  final User user;
  const SignupFirstPage(
      {super.key, required this.isUpdated, required this.user});

  @override
  State<SignupFirstPage> createState() => _SignupFirstPageState();
}

class _SignupFirstPageState extends State<SignupFirstPage> {
  bool updated = false;
  var _formKey = GlobalKey<FormState>();
  void onNextClick() {
    widget.isUpdated(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FirstPage(),
    );
  }

  Column FirstPage() {
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
                'What\'s your email address?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                  hintText: 'email',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  setState(() {
                    widget.user.email = value!;
                  });
                },
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.compose([
                  Validators.required('Email is required'),
                  Validators.email('Enter valid email'),
                ]),
                initialValue: widget.user.email,
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
              Row(
                children: [
                  Text('Male'),
                  Radio(
                    value: 'Male',
                    groupValue: widget.user.gender,
                    onChanged: (value) {
                      setState(() {
                        widget.user.gender = value!;
                      });
                    },
                  ),
                  Text('Female'),
                  Radio(
                    value: 'Female',
                    groupValue: widget.user.gender,
                    onChanged: (value) {
                      setState(() {
                        widget.user.gender = value!;
                      });
                    },
                  ),
                  Text('N/A'),
                  Radio(
                    value: 'NA',
                    groupValue: widget.user.gender,
                    onChanged: (value) {
                      setState(() {
                        widget.user.gender = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 2,
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
                padding: EdgeInsets.all(5),
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
                  onChanged: (value) {
                    setState(() {
                      widget.user.chosenValue = value!;
                    });
                  },
                  value: widget.user.chosenValue,
                ),
              )
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
                    onNextClick();
                  }
                },
                title: 'NEXT',
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

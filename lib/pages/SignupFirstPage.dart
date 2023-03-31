import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../utils/colors.dart';
import '../utils/globalMethods.dart';
import 'ButtonWidget.dart';

class SignupFirstPage extends StatefulWidget {
  final Function(bool) isUpdated;
  const SignupFirstPage({super.key, required this.isUpdated});

  @override
  State<SignupFirstPage> createState() => _SignupFirstPageState();
}

class _SignupFirstPageState extends State<SignupFirstPage> {
  bool updated = false;
  String _gender = "male";
  String _chosenValue = 'Once a week';
  var _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _emailFilled = false;
  bool _isNextButtonDisabled = true;

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
        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
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

  void onNextClick() {
    if (_emailFilled) {
      widget.isUpdated(true);
    }
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
                onChanged: setEmail,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: Validators.compose([
                  Validators.required('Email is required'),
                  Validators.email('Enter valid email'),
                ]),
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

import 'package:artem_app/layouts/login_page/forms.dart';
import 'package:artem_app/services/auth_service.dart';
import 'package:artem_app/services/models/school.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final String email;

  SignUpForm({Key key,  @required this.email}) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  School school;
  int yearEntered;
  double containerWidth;
  String confirmationCode;
  bool needsSignUp;

  String firstNameValidator(value) {
    if (value == '') {
      return 'Entre ton prénom';
    }
    setState(() {
      firstName = value;
    });
    return null;
  }

  String lastNameValidator(value) {
    if (value == '') {
      return 'Entre ton nom';
    }
    setState(() {
      lastName = value;
    });
    return null;
  }

  String yearEnteredValidator(value) {
    int parsedValue = int.tryParse(value);

    if (parsedValue == null || parsedValue > 1980 && parsedValue < 2100) {
      return 'Entre une année valide';
    }
    setState(() {
      yearEntered = value;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    containerWidth = 200;
    lastName = '';
    firstName = '';
    yearEntered = -1;
    confirmationCode = '';
    needsSignUp = false;
  }

  List<Widget> renderFormField() {
    if (lastName == '' && firstName == '' && yearEntered == -1) {
      return renderUserForm(
          [firstNameValidator, lastNameValidator, yearEnteredValidator]);
    }
    return renderSchoolSelector();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              width: 280,
              height: 250,
              child: Column(
                children: renderFormField(),
              ),
            ),
          ),
          AcceptButton(
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
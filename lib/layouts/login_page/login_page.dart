import
'dart:ui';

import 'package:artem_app/services/models/school.dart';
import 'package:flutter/material.dart';
import 'package:artem_app/layouts/common/background.dart';

import 'forms.dart';
import 'login_painter.dart';

bool emailValid(email) {
  List<String> splitMail = email.split('@');
  if (splitMail.length == 1) {
    return false;
  }
  String provider = splitMail[splitMail.length - 1];
  if (provider == 'etu.univ-lorraine.fr') {
    return true;
  }
  if (provider == 'my-icn.fr') {
    return true;
  }
  return false;
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(),
        FrostedGlassLoginContainer(),
        ForeGround(),
      ],
    );
  }
}

class AcceptButton extends StatelessWidget {
  final formKey;

  const AcceptButton({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.reset();
              // If the form is valid, display a Snackbar.
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Adresse acceptée')));
            }
          },
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          child: Text('Suivant', style: TextStyle(color: Colors.white))),
    );
  }
}

class ForeGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginForm(),
            ],
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  String email;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String firstName;
  String lastName;
  School school;
  int yearEntered;
  double containerWidth;
  String confirmationCode;

  String emailValidator(value) {
    if (!emailValid(value)) {
      return 'Utilise ton univ-lorraine ou my-icn';
    }
    setState(() {
      email = value;
    });
    return null;
  }

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
    email = '';
    lastName = '';
    firstName = '';
    yearEntered = -1;
    confirmationCode = '';
  }

  List<Widget> renderFormField() {
    if (email == '') {
      return renderEmailForm(emailValidator);
    } else if (lastName == '' && firstName == '' && yearEntered == -1) {
      return renderUserForm(
          [firstNameValidator, lastNameValidator, yearEnteredValidator]);
    }
    return renderSchoolSelector();
  }

  @override
  Widget build(BuildContext context) {
    print(containerWidth);
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

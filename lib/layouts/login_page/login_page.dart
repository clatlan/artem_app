import 'dart:ui';

import 'package:artem_app/layouts/login_page/sign_up_form.dart';
import 'package:artem_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:artem_app/layouts/common/background.dart';
import 'forms.dart';
import 'login_painter.dart';

bool emailParsingCorrect(email) {
  List<String> splitMail = email.split('@');
  if (splitMail.length != 2) {
    return false;
  }
  if (splitMail[0] == '' || splitMail[1] == '') {
    return false;
  }
  return true;
}

bool emailProviderCorrect(email) {
  List<String> splitMail = email.split('@');
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
  Function loginCallback;

  LoginPage(this.loginCallback);

  @override
  Widget build(BuildContext context) {
    var auth = AuthService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Background(),
          FrostedGlassLoginContainer(),
          ForeGround(this.loginCallback),
        ],
      ),
    );
  }
}

class ForeGround extends StatelessWidget {
  Function loginCallback;

  ForeGround(this.loginCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginForm(this.loginCallback),
            ],
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  Function loginCallback;

  LoginForm(this.loginCallback);

  @override
  _LoginFormState createState() => _LoginFormState(this.loginCallback);
}

class _LoginFormState extends State<LoginForm> {
  Function loginCallback;

  _LoginFormState(this.loginCallback);

  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  double containerWidth;
  String confirmationCode;
  bool needsSignUp;
  bool emailCheckupDone;

  String emailValidator(value) {
    if (!emailParsingCorrect(value)) {
      return 'Format incorrect';
    }
    if (!emailProviderCorrect(value)) {
      return 'Utilise ton univ-lorraine ou my-icn';
    }
    authService.doesEmailExist(value).then((doesEmailExist) {
      setState(() {
        needsSignUp = !doesEmailExist;
        email = value;
      });
    }).whenComplete(() {
      setState(() {
        emailCheckupDone = true;
      });
    });
    return null;
  }

  String confirmationCodeValidator(value) {
    if (value != '') {
      setState(() {
        confirmationCode = value;
      });
      return null;
    }
    return 'Rentre le code reçu par email';
  }

  @override
  void initState() {
    super.initState();
    containerWidth = 200;
    email = '';
    confirmationCode = '';
    emailCheckupDone = false;
    needsSignUp = false;
    confirmationCode = '';
  }

  List<Widget> renderFormField() {
    if (email == '') {
      return renderEmailForm([emailValidator]);
    } else if (needsSignUp) {
      return [SignUpForm(email: email)];
    } else if (confirmationCode == '') {
      authService.requestConfirmationCode(email);
      return renderLoginForm(email, confirmationCodeValidator);
    }
    authService.login(email, confirmationCode).then((onValue) {
      this.loginCallback();
    });
    return [CircularProgressIndicator()];
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

import 'package:artem_app/services/models/school.dart';
import 'package:flutter/material.dart';

School icn = School(id: -1, name: 'ICN Buisness School');
School mines = School(id: -1, name: 'Mines');
School ensad = School(id: -1, name: 'Ensad');


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

List<Widget> renderEmailForm(validators) {
  var validator = validators[0];
  return [
    Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(40),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              labelText: 'Ton email',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w300,
              )),
          validator: validator,
        ),
      ),
    )
  ];
}

List<Widget> renderLoginForm(email, validator) {
  return [
    Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Text(
          'Entre le code de confirmation (valable 24h) envoyé à '+ email+ ' pour te connecter'
        ),
      ),
    ),
    Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(40),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              labelText: 'Code de confirmation',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w300,
              )),
          validator: validator,
        ),
      ),
    )
  ];
}

List<Widget> renderUserForm(validators) {
  return [
    Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Column(
        children: <Widget>[
          TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Ton Prénom',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                )),
            validator: validators[0],
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Ton nom',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                )),
            validator: validators[1],
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Ta promotion',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                )),
            validator: validators[2],
            textInputAction: TextInputAction.next,
          )
        ],
      ),
    )
  ];
}

Widget schoolBox(school) {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: school.image(),
    ),
  );
}

List<Widget> renderSchoolSelector() {
  return [
    Text('Touche ton école',
        style: TextStyle(
          fontWeight: FontWeight.w300,
        )),
    Padding(
      padding: EdgeInsets.all(10),
    ),
    Row(
      children: <Widget>[
        schoolBox(icn),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        schoolBox(ensad),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        schoolBox(mines),
      ],
    )
  ];
}

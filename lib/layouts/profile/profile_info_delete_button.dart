import 'package:flutter/material.dart';

class ProfileInfoDeleteButton extends StatelessWidget {
  // final String questionText;

  //ProfileInfoDeleteButton(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(
          "Supprimer mon profile",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        textColor: Colors.white,
        color: Colors.red[500],
        onPressed: () => {},
      ),
    );
  }
}

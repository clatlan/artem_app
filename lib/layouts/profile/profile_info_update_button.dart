import 'package:flutter/material.dart';

class ProfileInfoUpdateButton extends StatelessWidget {
 // final String questionText;

  //ProfileInfoUpdateButton(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(
          "Mettre à jour",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () => {},
      ),
    );
  }
}

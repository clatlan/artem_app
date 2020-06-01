import 'package:flutter/material.dart';

class ProfileInfoDeleteButton extends StatelessWidget {
  // final String questionText;

  //ProfileInfoDeleteButton(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        elevation: 2,
        icon: Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
        label: Text(
          "Supprimer",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        textColor: Colors.white,
        color: Colors.red[600],
        onPressed: () => {},
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String text;
  //final nameId;
  final String textId;

  ProfileInfo(this.text, this.textId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          Spacer(),
          Text(
            //nameId,
            textId,
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

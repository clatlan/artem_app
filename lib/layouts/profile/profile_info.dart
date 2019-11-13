import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String text;
  //final nameId;
  final String textId;

  ProfileInfo(this.text, this.textId);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),
            Text(
              //nameId,
              textId,
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
	      SizedBox(height: 32.0),
      ],
    );
  }
}

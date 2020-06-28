import 'package:flutter/material.dart';

import 'package:artem_app/layouts/profile/update_profile_dialog.dart';
import '../../services/models/user.dart';


class ProfileInfoUpdateButton extends StatelessWidget {
  final User user;

  ProfileInfoUpdateButton({Key key, @required this.user});

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
          Icons.edit,
          color: Colors.white,
        ),
        label: Text(
          "Modifier mon profile",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return UpdateInfoDialog(user: user);
            },
          );
        },
      ),
    );
  }
}

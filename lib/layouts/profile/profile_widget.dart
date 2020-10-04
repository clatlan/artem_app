import 'package:flutter/material.dart';

import 'package:artem_app/custom_flutter/custom_dialog.dart' as customDialog;

import '../../services/models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;

  ProfileWidget({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        _getSchoolLogoImage(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(user.firstName + " " + user.lastName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(user.email,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
            //emailLabel,
            SizedBox(height: 20),
            Text("Informations personnelles",
                style: TextStyle(color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Divider(
                height: 1,
                color: Colors.pink,
              ),
            ),
            profileInfo("École", user.school.name),
            profileInfo("Promotion d'entrée", user.yearEntered.toString()),
            associationInfo(user),
          ],
        ),
      ],
    );
  }

  Widget profileInfo(String text, String textId) {
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
//            nameId,
            textId,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget associationInfo(User user) {
    final plural = user.roles.length > 1 ? 1 : 0;
    final label = "Association" + "s" * (plural);
    final content = user.unionsList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical :16.0),
      child: Row(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          Spacer(),
          Container(
            width: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: content.map((unionName) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      unionName,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileDialog extends StatelessWidget {
  final User user;

  ProfileDialog({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {
    return customDialog.AlertDialog(
      content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ProfileWidget(user: user)),
    );
  }
}
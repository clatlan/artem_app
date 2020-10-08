import 'package:flutter/material.dart';

import 'package:artem_app/custom_flutter/custom_dialog.dart' as customDialog;

import '../../services/models/user.dart';
import 'package:artem_app/layouts/common/union_page.dart';

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
            Text((user.firstName ?? "prénom") + " " + (user.lastName ?? "nom"),
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(user.email ?? "Aucun mail à afficher.",
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
            profileInfo("École", user.school?.name ?? " "),
            profileInfo("Promotion d'entrée", user.yearEntered?.toString() ?? " "),
            associationInfo(user, context),
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

  Widget associationInfo(User user, BuildContext context) {
    final plural = user.roles.length > 1 ? 1 : 0;
    final label = "Association" + "s" * (plural);
    final content = user.unionsList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                children: content.map((union) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: union.logo != null
                        ? Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(200)),
                            border: Border.all(width: 0.2, color: Colors.grey),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(200)),
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(200),
                              ),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return UnionPage(union: union);
                                    },
                                  );
                                },
                                child: Image.asset(
                                  'assets/images_test/BDE.png',
                                  fit: BoxFit.fill,
                                )

                              ),
                            ),
                          ),
                        )
                    : Text(
                      union.name,
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
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(child: ProfileWidget(user: user)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }
}

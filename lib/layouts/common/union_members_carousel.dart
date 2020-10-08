import 'package:flutter/material.dart';

import '../profile/profile_widget.dart';
import '../../services/models/user.dart';
import '../../services/models/role.dart';
import '../../services/models/union.dart';

class UnionMembersCarousel extends StatelessWidget {
  final Union union;

  UnionMembersCarousel({Key key, @required this.union});

  String getMemberRole(User member) {
    String roleName;
    for (Role role in member.roles) {
      if (role.union.id == union.id) {
        roleName = role.name;
      } else {
        roleName = "Aucun poste";
      }
    }
    return roleName;
  }

  Widget miniMemberCard(BuildContext context, User member) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          borderOnForeground: true,
          child: InkWell(
            highlightColor: Colors.blue[300],
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProfileDialog(user: member);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                    Text(
                      getMemberRole(member),
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      member.firstName + " " + member.lastName,
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: union.members != null
            ? Row(
                children: union.members.map((member) {
                return miniMemberCard(context, member);
              }).toList())
            : Container(),
      ),
    );
  }
}

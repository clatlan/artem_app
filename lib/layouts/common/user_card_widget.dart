import 'package:flutter/material.dart';

import '../../services/models/user.dart';




class UserCardWidget extends StatefulWidget {
  final User user;

  UserCardWidget({Key key,  @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserCardWidgetState();
}

class UserCardWidgetState extends State<UserCardWidget> {

  Future<User> user;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}
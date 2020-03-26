import 'package:flutter/material.dart';

import 'package:artem_app/layouts/profile/update_profile_dialog.dart';
import '../../services/models/user.dart';

//class MyStatefulWidget extends StatefulWidget {
////  MyStatefulWidget({Key key}) : super(key: key);
//
//  @override
//  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
//}
//
//class _MyStatefulWidgetState extends State<MyStatefulWidget>
//    with SingleTickerProviderStateMixin {
//  AnimationController _controller;
//  Animation<Offset> _offsetAnimation;
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = AnimationController(
//      duration: const Duration(seconds: 2),
//      vsync: this,
//    )..forward();
////    )..repeat(reverse: false);
//    _offsetAnimation = Tween<Offset>(
//      begin: const Offset(0, 1.5),
//      end: Offset.zero,
//    ).animate(CurvedAnimation(
//      parent: _controller,
//      curve: Curves.ease,
//    ));
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _controller.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SlideTransition(
//      position: _offsetAnimation,
//      child: const Padding(
//        padding: EdgeInsets.all(8.0),
//        child: Text("HEYYY"),
//      ),
//    );
//  }
//}



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

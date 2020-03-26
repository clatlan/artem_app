import 'package:flutter/material.dart';

import 'package:artem_app/custom_flutter/custom_dialog.dart' as customDialog;

import '../../services/models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;

  ProfileWidget({Key key, @required this.user});

  Widget _getSchoolLogoImagePath() {
    if (user.school.name == "Mines") {
      return Positioned(
        top: 200,
        left: 50,
        right: 50,
        child: Opacity(
          opacity: 0.05,
          child: Image.asset("assets/images/logoMINEScropped.jpg", scale: 3.0),
        ),
      );
    } else if (user.school.name == "Ensad") {
      return Positioned(
        top: 240,
        left: 50,
        right: 50,
        child: Opacity(
          opacity: 0.05,
          child: Image.asset("assets/images/logoENSADcropped.jpg", scale: 1.5),
        ),
      );
    } else if (user.school.name == "ICN Business School") {
      print("hey logo icn");
      return Positioned(
        top: 220,
        left: 50,
        right: 50,
        child: Opacity(
          opacity: 0.05,
          child: Image.asset("assets/images/logoICN.png", scale: 1.5),
        ),
      );
    }
    // By default, return an empty container
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _getSchoolLogoImagePath(),
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
            //nameId,
            textId,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget associationInfo(User user) {
    final plural = user.roles.length > 1 ? 1 : 0;
    final label = "Association" + "s" * (plural);
    final content = user.unionsString();
    return profileInfo(label, content);
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

//
//
//class ProfileWidgetOld extends StatefulWidget {
//  final User user;
//
//  ProfileWidgetOld({Key key, @required this.user}) : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() => ProfileState();
//}
//
//class UserInfo extends StatelessWidget {
//  final User user;
//
//  UserInfo({Key key, @required this.user}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      children: <Widget>[
//        Text(user.firstName + " " + user.lastName,
//            style: TextStyle(fontWeight: FontWeight.bold)),
//        SizedBox(height: 20),
//        Text(user.email,
//            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
//        //emailLabel,
//        SizedBox(height: 20),
//        Text("Informations personnelles",
//            style: TextStyle(color: Colors.black)),
//        Padding(
//          padding: const EdgeInsets.only(top: 4.0, bottom: 8),
//          child: Divider(
//            height: 1,
//            color: Colors.pink,
//          ),
//        ),
//        //firstNameLabel,
//        Column(
//          children: <Widget>[
////            ProfileInfo("Nom", user.lastName),
////            ProfileInfo("Prénom", user.firstName),
//            ProfileInfo("École", user.school.name),
//            ProfileInfo("Promotion d'entrée", user.yearEntered.toString()),
//            associationInfo(user)
//          ],
//        ),
//      ],
//    );
//  }
//
//  Widget associationInfo(User user) {
//    final plural = user.roles.length > 1 ? 1 : 0;
//    final label = "Association" + "s" * (plural);
//    final content = user.unionsString();
//    return ProfileInfo(label, content);
//  }
//}
//
//class ProfileState extends State<ProfileWidgetOld> {
//  Future<User> user;
//  final authService = AuthService();
//
//  @override
//  void initState() {
//    super.initState();
//    final dataFactory = DataFactory();
//    user = dataFactory.fetchUser(authService.currentUser());
//  }
//
//  AssetImage _getSchoolLogoImage(String schoolName) {
//    String filePath;
//    if (schoolName == "Mines") {
//      filePath = "assets/images/logoMINES.jpg";
//    } else if (schoolName == "Ensad") {
//      filePath = "assets/images/logoENSAD.jpg";
//    } else if (schoolName == "ICN Business School") {
//      filePath = "assets/images/logoICN.png";
//    }
//    return AssetImage(filePath);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<User>(
//      future: user,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return Stack(
//            children: <Widget>[
//              Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    colorFilter: ColorFilter.mode(
//                        Colors.black.withOpacity(0.05), BlendMode.dstATop),
//                    image: _getSchoolLogoImage(snapshot.data.school.name),
////                fit: BoxFit.cover,
//                  ),
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 48.0),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Colors.grey[300],
//                      ),
//                      child: Icon(
//                        Icons.person,
//                        size: 100,
//                        color: Colors.white,
//                      ),
//                    ),
//                    SizedBox(height: 20),
//                    UserInfo(user: snapshot.data),
//                  ],
//                ),
//              ),
//            ],
//          );
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner.
//        return Scaffold(body: Center(child: Loader()));
//      },
//    );
//  }
//}

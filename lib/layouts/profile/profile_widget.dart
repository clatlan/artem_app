import 'package:flutter/material.dart';

import './profile_info.dart';
import './profile_info_update_button.dart';
import './profile_info_delete_button.dart';

import '../../services/models/user.dart';
//import '../../services/models/school.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';




class ProfileWidget extends StatefulWidget {
  final User user;

  ProfileWidget({Key key,  @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfileWidget> {

  Future<User> user;
  final authService = AuthService();


  @override
  void initState() {
    super.initState();
    final dataFactory = DataFactory();
    user = dataFactory.fetchUser(authService.currentUser());
  }

  Widget associationInfo (User user) {
    final plural = user.roles.length > 1 ? 1 : 0;
    final label = "Association" + "s" * (plural);
    final content = user.unionsString();
    return ProfileInfo(label, content);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.05), BlendMode.dstATop),
                      image: AssetImage("assets/images/logoMINES.jpg"),
//                fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              //logo,
                              SizedBox(height: 48.0),
                              //userIdLabel,
                              Center(
                                child: Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Text(snapshot.data.email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink))),
                              ),
                              SizedBox(height: 30.0),
                              //emailLabel,
                              Text("Informations personnelles",
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(height: 6.0),
                              Divider(
                                height: 1,
                                color: Colors.pink,
                              ),
                              //firstNameLabel,
                              SizedBox(height: 24.0),
                              Column(
                                children: <Widget>[
                                  ProfileInfo("Nom", snapshot.data.lastName),
                                  ProfileInfo("Prénom", snapshot.data.firstName),
                                  ProfileInfo("Ecole", snapshot.data.school.name),
                                  ProfileInfo("Promotion", snapshot.data.yearEntered.toString()),
                                  associationInfo(snapshot.data)
                                ],
                              ),
                              ProfileInfoUpdateButton(),
                              ProfileInfoDeleteButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    ) ;
  }

}
import 'package:flutter/material.dart';

import '../../services/models/user.dart';
import 'package:artem_app/layouts/common/loader.dart';
import 'package:artem_app/layouts/profile/profile_widget.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';
import './profile_info_update_button.dart';
import './profile_info_delete_button.dart';

class MyProfile extends StatefulWidget {
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<User> user;
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    final dataFactory = DataFactory();
    user = dataFactory.fetchUser(authService.currentUser());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: Text("Mon profile")),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 48.0),
                      child: ProfileWidget(user: snapshot.data),
                    ),
                    SizedBox(height: 20),
//                    ProfileInfoUpdateButton(user: snapshot.data),
                    ProfileInfoDeleteButton(),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Scaffold(body: Center(child: Loader()));
      },
    );
  }
}

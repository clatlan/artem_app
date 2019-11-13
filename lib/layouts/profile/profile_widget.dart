import 'package:flutter/material.dart';

import './profile_info.dart';
import './profile_info_update_button.dart';
import './profile_info_delete_button.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
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
                              child: Text("clement.atlan@mines-nancy.org",
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
                            ProfileInfo("Nom", "Atlan"),
                            ProfileInfo("Prénom", "Clément"),
                            ProfileInfo("Ecole", "Mines"),
                            ProfileInfo("Promotion", "2016"),
                            ProfileInfo("Association", "BDE"),
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
  }
}

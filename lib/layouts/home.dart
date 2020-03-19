import 'package:flutter/material.dart';

import 'crous_info/crous_info_widget.dart';
import 'event/event_widget.dart';
import 'profile/profile_widget.dart';
import 'search/search_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool checkLoginFinished = false;
  bool isLoggedIn;
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetLayout = [
    ProfileWidget(),
    SearchWidget(),
    EventWidget(),
    CrousInfoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: _widgetLayout.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profil'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Recherche'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note),
                title: Text('Evènements'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text('Informations'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.pink,
            onTap: _onItemTapped,
            iconSize: 20.0,
            unselectedFontSize: 15,
            type: BottomNavigationBarType.fixed,
          ),
          resizeToAvoidBottomPadding: false),
    );
  }
}

import 'package:flutter/material.dart';

import 'crous_info/crous_info_widget.dart';
import 'event/event_page.dart';
import 'home_page/home_page.dart';
import 'search/search_widget.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({Key key}) : super(key: key);

  @override
  State<HomeNavBar> createState() => HomeNavBarState();
}

class HomeNavBarState extends State<HomeNavBar> {
  bool checkLoginFinished = false;
  bool isLoggedIn;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void redirectToSearch() {
    setState(() {
      _selectedIndex = 1;
    });
  }

    @override
    Widget build(BuildContext context) {
      List<Widget> _widgetLayout = [
        HomePage(this.redirectToSearch),
        SearchWidget(),
        EventPage(),
        CrousInfoPage(),
      ];
      return SafeArea(
        child: Scaffold(
            body: Center(
              child: _widgetLayout.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 32,),
                  title: Text('Accueil'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 32),
                  title: Text('Recherche'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_note, size: 32),
                  title: Text('Evènements'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info, size: 32,),
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

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
  final List<Widget> _widgetLayout = [
    Container(),
    SearchWidget(),
    EventPage(),
    CrousInfoWidget(),
  ];
  
  Widget selectWidget(int index){
    if (index == 0)  {
      return HomePage(this.redirectToSearch);
    }else{
      return _widgetLayout.elementAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: selectWidget(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Accueil'),
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

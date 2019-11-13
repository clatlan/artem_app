// Flutter code sample for

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import './layouts/event/event_widget.dart';
import './layouts/search/search_widget.dart';
import './layouts/profile/profile_widget.dart';
import './layouts/crous_info/crous_info_widget.dart';


void main() {
	initializeDateFormatting().then((_) => runApp(MyApp()));
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Profile',
      style: optionStyle,
    ),
    Text(
      'Index 1: Recherche',
      style: optionStyle,
    ),
    Text(
      'Index 2: Evènements',
      style: optionStyle,
    ),
    Text(
      'Index 3: Services',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

	final List<Widget> _widgetLayout = [
		ProfileWidget(),
		SearchWidget(),
		EventWidget(),
		CrousInfoWidget('hey'),
	];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artem App Sample'),
      ),
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
    );
  }
}

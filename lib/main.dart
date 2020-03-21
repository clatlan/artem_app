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

import 'package:artem_app/layouts/home.dart';
import 'package:artem_app/layouts/login_page/login_page.dart';
import './services/auth_service.dart';
import 'layouts/common/background.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Artem App';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          keyboardManagement(context);
        },
        child: MaterialApp(
          title: _title,
          home: StateProvider(),
        ));
  }
}

void keyboardManagement(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

class StateProvider extends StatefulWidget {
  StateProvider({Key key}) : super(key: key);

  @override
  StateProviderState createState() => StateProviderState();
}

class StateProviderState extends State<StateProvider> {
  bool checkLoginFinished;
  bool isLoggedIn;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkLoginFinished = false;
    isLoggedIn = false;
  }

  void checkLogin() {
    authService.isLoggedIn().then((returnedIsLoggedIn) {
      setState(() {
        print(returnedIsLoggedIn);
        isLoggedIn = returnedIsLoggedIn;
      });
    }).whenComplete(() {
      setState(() {
        checkLoginFinished = true;
      });
    });
  }

  void loginCallback() {
    setState(() {
      this.isLoggedIn = true;
    });
  }

  Widget displayPage() {
    if (!checkLoginFinished) {
      checkLogin();
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Background(),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }
    return isLoggedIn ? HomePage() : LoginPage(this.loginCallback);
  }

  @override
  Widget build(BuildContext context) {
    return displayPage();
  }
}

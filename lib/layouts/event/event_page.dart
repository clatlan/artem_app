import './calendar.dart';
import 'package:flutter/material.dart';
import 'package:artem_app/services/models/user.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';
import 'add_event_popup.dart';

// gérer le layout du widget avec le carousel

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Calendar(), AddButton()],
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataFactory = DataFactory();
    final authService = AuthService();

    final Future<User> user = dataFactory.fetchUser(authService.currentUser());
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.canAddEvent()) {
          return Container(
            padding: EdgeInsets.only(right: 50, bottom: 50),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddEvent();
                  },
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
        }
        return Container();
      },
    );
  }
}

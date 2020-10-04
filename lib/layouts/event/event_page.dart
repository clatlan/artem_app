import './calendar.dart';
import 'package:flutter/material.dart';
import 'package:artem_app/services/models/user.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';
import 'add_event_page.dart';

// gérer le layout du widget avec le carousel

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Calendar(), Carousel(), AddButton()],
    );
  }
}

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return Container();
  }
}


class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Future<User> user = DataFactory().fetchUser(AuthService().currentUser());
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
                    return AddEvent(user: snapshot.data);
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

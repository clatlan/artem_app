import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:artem_app/services/models/user.dart';
import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/event.dart';
import 'package:artem_app/services/auth_service.dart';
import 'package:artem_app/layouts/common/loader.dart';

import './calendar.dart';
import 'package:artem_app/layouts/event/event_widgets.dart';
import 'add_event_page.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<List<Event>> _events = DataFactory().fetchEvents();
    return FutureBuilder<List<Event>>(
      future: _events,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(flex: 2, child: Calendar()),
                    Expanded(
                      flex: 1,
//                          height: MediaQuery.of(context).size.height * 0.3,
                      child: Carousel(
                        events: snapshot.data,
                      ),
                    ),
//                    SizedBox(height: 120),
                  ],
                ),
              ),
              Positioned(bottom: 15, right: 20,
                  child: AddButton())
            ],
          );

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Loader();
        }
      },
    );
  }
}

class Carousel extends StatelessWidget {
  final List<Event> events;

  Carousel({Key key, @required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.8,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          items: events.map((event) {
            return EventPreview(event: event);
          }).toList()),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<User> user =
        DataFactory().fetchUser(AuthService().currentUser());
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.canAddEvent()) {
          return Container(
//            padding: EdgeInsets.only(right: 50, bottom: 50),
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

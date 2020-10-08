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

//List<Event> sortEvent(List<Event> events) {
//    events.sort((eventA, eventB) {
//    return eventA.timeStart.compareTo(eventB.timeStart);
//  });
//    return events;
//}
//
//List<Event> prepareEventsList(List<Event> events) {
//  Event todayEvent = Event(name: "todayEvent", timeStart: DateTime.now());
//  events.add(todayEvent);
//  events = sortEvent(events);
//  int indexToCut = events.indexOf(todayEvent);
//
////  for (int i = 0; i < events.length; i++) {
////    if (events[i] == todayEvent) {
////      indexToCut = i;
////    }
////  }
//  return events.sublist(indexToCut + 1, events.length);
//}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> eventList;
  Event selectedEvent;

  Carousel carousel;

  void initCarousel() {
    carousel = new Carousel(events: eventList);
  }

  void jumpToEvent(Event event) {
    for (int i = 0; i < eventList.length; i++) {
      if (event.id == eventList[i].id) {
        print("hey page controller");
        carousel.jumpToPage(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Event>> _events = DataFactory().fetchEvents();
    return FutureBuilder<List<Event>>(
      future: _events,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          eventList = snapshot.data;
          initCarousel();
          return Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: MyCalendar(
                          events: eventList, jumpToEvent: jumpToEvent),
                    ),
                    Expanded(
                      flex: 1,
//                          height: MediaQuery.of(context).size.height * 0.3,
                      child: carousel,
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              Positioned(bottom: 15, right: 20, child: AddButton())
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
  final CarouselController carouselController = CarouselController();
  final List<Event> events;

  Carousel({Key key, @required this.events});

  void jumpToPage(int page) {
    print(page);
    carouselController.animateToPage(page,
        duration: Duration(milliseconds: 1200), curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.9,
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

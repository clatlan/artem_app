import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class Calendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => new _MyCalendarState();
}

Map<DateTime, List<dynamic>> prepareEvents(List<Event> events) {
  Map<DateTime, List<dynamic>> eventJson = {};
  for (var i = 0; i < events.length; i++) {
    var eventDate = events[i].timeStart;
    var jsonKey = DateTime(eventDate.year, eventDate.month, eventDate.day);
    if (eventJson.containsKey(jsonKey)) {
      eventJson[jsonKey].add(events[i].name);
    } else {
      eventJson[jsonKey] = [events[i].name];
    }
  }
  return eventJson;
}

class _MyCalendarState extends State<Calendar> {
  Future<List<Event>> _events;
  List _selectedEvents;
  DateTime _selectedDay;
  CalendarController _calendarController;
  final dataFactory = DataFactory();

  @override
  void initState() {
    super.initState();

    final _todayDay = DateTime.now();

    _events = dataFactory.fetchEvents();
    _selectedEvents = [];

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(List events) {
    setState(
      () {
        _selectedEvents = events;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//        ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return FutureBuilder(
        future: _events,
        builder: (context, snapshot) {
          Map<DateTime, List<dynamic>> formattedEvents;
          if (snapshot.hasData) {
            formattedEvents = prepareEvents(snapshot.data);
          } else {
            formattedEvents = Map<DateTime, List<dynamic>>.from({});
          }
          return CalendarCarousel(
            locale: 'fr_FR',
            height: MediaQuery.of(context).size.height * 0.5,
            weekendTextStyle: TextStyle(color: Colors.pink),
            weekdayTextStyle: TextStyle(color: Colors.blue),
            todayButtonColor: Colors.blue,
            selectedDayTextStyle: TextStyle(color: Colors.pink),
            markedDateWidget: Positioned(
              child: Container(
                color: Colors.green,
                height: 4.0,
                width: 4.0,
              ),
              bottom: 4.0,
              left: 18.0,
            ),
            iconColor: Colors.pink,

            onDayPressed: (DateTime date, List<Event> events) {
              return Container(
                decoration: new BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(4.0),
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }, //             markedDatesMap: formattedEvents,
          );
        });
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents != []
          ? _selectedEvents
              .map((event) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      title: Text(event.toString()),
                      onTap: () => null,
                    ),
                  ))
              .toList()
          : DayWidget(_selectedDay),
    );
  }
}

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class DayWidget extends StatelessWidget {
  final DateTime day;

  DayWidget(this.day);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        'Coucou',
//        DateFormat.yMMMMd("fr_FR").format(day),
        style: TextStyle(
          fontFamily: 'Artem',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

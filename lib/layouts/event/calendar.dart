import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import 'package:artem_app/services/models/event.dart';

Map<DateTime, List<Event>> prepareEvents(List<Event> events) {
  Map<DateTime, List<Event>> eventJson = {};
  for (var i = 0; i < events.length; i++) {
    var eventDate = events[i].timeStart;
    var jsonKey = DateTime(eventDate.year, eventDate.month, eventDate.day);
    if (eventJson.containsKey(jsonKey)) {
      eventJson[jsonKey].add(events[i]);
    } else {
      eventJson[jsonKey] = [events[i]];
    }
  }
  return eventJson;
}

//int getEventIndex(DateTime date, List<Event> events){
//  for (int i = 0; i < events.length; i++){
//    if (date.day == events[i].timeStart.day) {
//
//      return i;
//    }
//  }
//  return null;
//}

class MyCalendar extends StatefulWidget {
  final List<Event> events;
  final void Function(Event event) jumpToEvent;

  MyCalendar({Key key, @required this.events, @required this.jumpToEvent});

  @override
  MyCalendarState createState() => new MyCalendarState();
}

class MyCalendarState extends State<MyCalendar> {
  DateTime selectedDay;
  EventList<Event> events;

  @override
  void initState() {
    super.initState();
    events = EventList<Event>(events: prepareEvents(widget.events));
  }

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      locale: 'fr_FR',
      weekendTextStyle: TextStyle(color: Colors.pink),
      weekdayTextStyle: TextStyle(color: Colors.blue),
      todayButtonColor: Colors.lightBlueAccent,
      selectedDayTextStyle: TextStyle(color: Colors.white),
      showHeader: true,
      showHeaderButton: true,
      markedDatesMap: events,
      selectedDateTime: selectedDay,
      selectedDayButtonColor: Colors.pink,
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => selectedDay = date);
        if (events.isNotEmpty) {
          widget.jumpToEvent(events[0]);
        }
      },
    );
  }
}

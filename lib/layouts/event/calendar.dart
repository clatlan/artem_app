import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => new _MyCalendarState();
}

class _MyCalendarState extends State<Calendar> {
//  @override
//  void initState() {
//    super.initState();
//  }
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'fr_FR',
      events: _selectedDay,
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(color: Colors.blue),
        weekendStyle: TextStyle(color: Colors.pink),
        outsideStyle: TextStyle(color: Colors.grey),
        unavailableStyle: TextStyle(color: Colors.yellow),
        outsideWeekendStyle: TextStyle(color: Colors.grey),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
//        dowTextBuilder: (date, locale) {
//          return DateFormat.E(locale)
//              .format(date)
//              .substring(0, 3)
//              .toUpperCase();
//        },
        weekdayStyle: TextStyle(color: Colors.blue),
        weekendStyle: TextStyle(color: Colors.pink),
      ),
      headerVisible: true,
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          return [
            Container(
              decoration: new BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(4.0),
              width: 4,
              height: 4,
            )
          ];
        },
        selectedDayBuilder: (context, date, _) {
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
        },
      ),
    );
  }


  final Map<DateTime, List> _selectedDay = {
    DateTime(2019, 4, 3): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 5): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 24): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 26): ['Selected Day in the calendar!'],
  };
}

//final Map<DateTime, List> holidays

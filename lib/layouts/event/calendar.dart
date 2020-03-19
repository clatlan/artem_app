import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  Future <List<Event>> _events;
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
          }
          else {
            formattedEvents = Map<DateTime, List<dynamic>>.from({});
          }

          return TableCalendar(
            locale: 'fr_FR',
            events: Map<DateTime, List<dynamic>>.from(formattedEvents),
            calendarController: _calendarController,
            holidays: _holidays,
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
            onDaySelected: (_, events) {
              _onDaySelected(events);
            },
            onVisibleDaysChanged: null,
          );
        }

    );

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

//final Map<DateTime, List> _selectedDay = {
//  DateTime(2019, 11, 16): ['Sarass'],
//  DateTime(2019, 11, 5): ['Selected Day in the calendar!'],
//  DateTime(2019, 11, 22): ['Selected Day in the calendar!'],
//  DateTime(2019, 12, 24): ['Selected Day in the calendar!'],
//  DateTime(2019, 11, 26): ['Selected Day in the calendar!'],
//};

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

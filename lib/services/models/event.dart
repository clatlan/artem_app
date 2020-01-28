import 'package:artem_app/services/models/union.dart';

class Event {
  final int id;
  final String name;
  final DateTime timeStart;
  final DateTime timeEnd;

  final Union union;

  Event({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.union,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        timeStart: DateTime.parse(json['time_start']),
        timeEnd: DateTime.parse(json['time_end']),
        union: Union.fromJson(json['union'])
    );
  }
}
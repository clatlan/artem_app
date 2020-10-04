import 'package:artem_app/services/models/union.dart';
import 'dart:io';

class Event {
  final int id;
  final String name;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String description;
  final String place;
  final File image;
  final Union union;

  Event({
    this.id,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.description,
    this.place,
    this.image,
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
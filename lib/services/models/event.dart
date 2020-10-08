import 'package:artem_app/services/models/union.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class Event extends EventInterface{
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

  DateTime getDate() {
    return this.timeStart;
  }

  String getTitle() {
    return this.name;
  }
  Icon getIcon() {
    return Icon(Icons.event);
  }

  Widget getDot(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(9.0),
      child: Container(
        height: 5,
        width: 5,
        color: Color(0xFF0288D1),
      ),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    Image img;

    if (json['image_picture'] != null) {
      img = Image.network(json['image_picture']);
    }
    return Event(
      id: json['id'],
      name: json['name'],
      timeStart: DateTime.parse(json['time_start']),
      timeEnd: DateTime.parse(json['time_end']),
      union: Union.fromJson(json['union']),
      description: json['description'],
      place: json['place'],
//      image: img,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['id'] = this.id;
    json['name'] = this.name;
    json['time_start'] = this.timeStart;
    json['time_end'] = this.timeEnd;
    json['union_id'] = this.union.id;

    return json;
  }

}
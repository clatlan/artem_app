import 'dart:ui';
import 'package:flutter/material.dart';

class School {
  final int id;
  final String name;

  School({this.id, this.name});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(id: json['id'], name: json['name']);
  }

  Image image() {
    var filepath = this.name == 'ICN Buisness School'
        ? 'assets/images/logoICN.png'
        : 'assets/images/logo${this.name.toUpperCase()}.jpg';
    return Image(width: 100, image: AssetImage(filepath));
  }
}

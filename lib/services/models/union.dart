import './school.dart';
//import 'dart:io';
import "package:flutter/material.dart";

import './user.dart';

class Union {
  final int id;
  final String name;
  final School school;
  final String description;
//  final File logo;
//  final File image;
  final Image logo;
  final Image image;
  final List<User> members;

  Union({
    this.id,
    this.name,
    this.school,
    this.description,
    this.logo,
    this.image,
    this.members
  });

  factory Union.fromJson(Map<String, dynamic> json) {

    return Union(
      id: json['id'],
      name: json['name'],
      school: School.fromJson(json['school'])
    );
  }
//  String fullName() {
//    return this.name + ' ' + this.school.name;
//  }
}
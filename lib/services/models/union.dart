import './school.dart';

class Union {
  final int id;
  final String name;
  final School school;

  Union({
    this.id,
    this.name,
    this.school
  });

  factory Union.fromJson(Map<String, dynamic> json) {

    return Union(
      id: json['id'],
      name: json['first_name'],
      school: School.fromJson(json['school'])
    );
  }
}
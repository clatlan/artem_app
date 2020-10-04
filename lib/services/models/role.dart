import './union.dart';

class Role {
  final int id;
  final String name;
  final bool canPublish;
  final Union union;

  Role({this.id, this.name, this.canPublish, this.union});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      canPublish: json['can_publish'],
      union: Union.fromJson(json['union'])
    );
  }
}
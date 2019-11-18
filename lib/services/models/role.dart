import './union.dart';

class Role {
  final int id;
  final String name;
  final bool can_publish;
  final Union union;

  Role({this.id, this.name, this.can_publish, this.union});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      can_publish: json['can_publish'],
      union: Union.fromJson(json['union'])
    );
  }
}
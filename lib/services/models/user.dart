import './school.dart';
import './role.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int yearEntered;

  final School school;
  final List<Role> roles;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.yearEntered,
      this.school,
      this.roles});

  factory User.bareUserFromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        yearEntered: json['year_entered'],
        school: School.fromJson(json['school']),
        roles: buildRoleList(json['user_roles']));
  }

  String unionsString() {
    final List<String> unions = [];
    for (var i = 0; i < this.roles.length; i++) {
      unions.add(roles[i].union.name);
    }
    return unions.join(', ');
  }

  List<String> unionsList() {
    final List<String> unions = [];
    for (var i = 0; i < this.roles.length; i++) {
      unions.add(roles[i].union.name);
    }
//    return unions.join(', ');
    return unions;
  }


  bool canAddEvent() {
    for (var i = 0; i < this.roles.length; i++) {
      if (this.roles[i].canPublish) {
        return true;
      }
    }
    return false;
  }
}

List<Role> buildRoleList(List listRoles) {
  final roles = <Role>[];
  for (var i = 0; i < listRoles.length; i++) {
    roles.add(Role.fromJson(listRoles[i]['user_role']['role']));
  }
  return roles;
}

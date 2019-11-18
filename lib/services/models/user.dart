import './school.dart';
import './role.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int yearEntered;

  final School school;
  //final List<Role> roles;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.yearEntered,
    this.school
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      yearEntered: json['year_entered'],
      school: School.fromJson(json['school'])
    );
  }

  List <Role> buildRoleList(Map<String, dynamic> json) {
    final roles = <Role> [];
    print(json['user_role']);
    return roles;
  }
}
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../services/variables.dart' as globals;
import './user.dart';
import '../../services/auth_service.dart';

class DataFactory {
  final auth = AuthService();

  Future<User> fetchUser(int i) async {
    final response = await http.get(
      globals.endpoint + '/api/v1/users/' + i.toString(),
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return User.fromJson(user['user']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  Future<List<User>> fetchUsers({startsWith = ''}) async {
    final response = await http.get(
      globals.endpoint + '/api/v1/users',
      headers: {'Authorization': auth.jwt(), 'starts_with': startsWith},
    );

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<User> users = [];
      for (var i = 0; i < list.length; i++) {
        users.add(User.fromJson(list[i]['user']));
      }
      return users;
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }
}

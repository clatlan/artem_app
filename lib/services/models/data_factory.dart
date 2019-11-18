import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../services/variables.dart' as globals;
import './user.dart';

class DataFactory {

  Future<User> fetchUser(int i) async {
    final response =
    await http.get(globals.endpoint + '/api/v1/users/' + i.toString());

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return User.fromJson(user['user']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
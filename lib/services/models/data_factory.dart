import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../services/variables.dart' as globals;
import './user.dart';
import '../../services/auth_service.dart';


class DataFactory {

  final auth = AuthService();

  Future<User> fetchUser(int i) async {
    print(auth.jwt());
    final response =
    await http.get(globals.endpoint + '/api/v1/users/' + i.toString(),
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return User.fromJson(user['user']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Nous sommes désolé une erreur est survenue, veuillez réessayer plus tard.');
    }
  }
}
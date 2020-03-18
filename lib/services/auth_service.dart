import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'variables.dart' as globals;

import 'dart:convert';

class AuthService {
  static String token;
  static int authenticatedUserId;

  String jwt() {
    return token;
  }

  int currentUser() {
    return authenticatedUserId;
  }

  Future<bool> isLoggedIn() async {
    await updateHotJwt();
    if (authenticatedUserId == null) {
      return false;
    }
    final response = await http.get(
      globals.endpoint + '/api/v1/users/' + authenticatedUserId.toString(),
      headers: {'Authorization': jwt()},
    );
    return response.statusCode == 200;
  }

  Future<void> updateHotJwt() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: 'artem_app_jwt');
    authenticatedUserId = parseJwt(token)['user_id'];
  }

  void saveJwtToHotAndColdStorage(String receivedToken) {
    final storage = new FlutterSecureStorage();
    token = receivedToken;
    authenticatedUserId = parseJwt(receivedToken)['user_id'];
    storage.write(key: 'artem_app_jwt', value: receivedToken);
  }

  Future<void> requestConfirmationCode(String email) async {
    var response = await http.post(
      globals.endpoint + '/users/confirmation_code',
      body: {
        'email': email,
      },
    );
  }

  Future<void> login(String email, String validationCode) async {
    var response = await http.post(
      globals.endpoint + '/authenticate',
      body: {'email': email, 'validation_code': validationCode},
    );
    if (response.statusCode == 200) {
      var jwt = json.decode(response.body)['auth_token'];
      saveJwtToHotAndColdStorage(jwt);
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
    return;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<bool> doesEmailExist(email) async {
    final response = await http.get(
      globals.endpoint + '/api/v1/user_by_email?email=' + email,
    );
    return response.statusCode == 200;
  }
}

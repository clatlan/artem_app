import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthService {

  static String token;
  static int authenticatedUserId;

  String jwt () {
    return token;
  }

  int currentUser() {
    return authenticatedUserId;
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

}
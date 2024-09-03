import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:survey_app/modules/common/data/repositoty/repository.dart';

class LoginRepository extends BaseRepository {
  Future<http.Response> register(Map<String, dynamic> body) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final String jsonBody = jsonEncode({
      "email": body["email"],
      "password": body["password"],
      "role": "user",
      "username": body["username"],
    });

    http.Response response = await post(
      '/register',
      jsonBody,
      headers,
    );

    log('Register repository: ${response.body}');
    return response;
  }

  Future<http.Response> login(String userName, String password) async {
    final Map<String, dynamic> body = {
      "username": userName,
      "password": password,
    };
    http.Response response = await post('/users/token/', body, {});

    return response;
  }
}

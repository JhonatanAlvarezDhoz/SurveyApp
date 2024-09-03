import 'dart:convert';

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

    return response;
  }

  Future<http.Response> login(Map<String, dynamic> body) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final String jsonBody = jsonEncode({
      "password": body["password"],
      "username": body["username"],
    });

    http.Response response = await post('/login', jsonBody, headers);

    return response;
  }
}

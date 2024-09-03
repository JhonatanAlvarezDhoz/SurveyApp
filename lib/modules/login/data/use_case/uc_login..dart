import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:survey_app/modules/common/data/use_case/use_case.dart';
import 'package:survey_app/modules/login/data/models/m_user_session.dart';
import 'package:survey_app/modules/login/data/repository/r_login.dart';

class LoginUseCaseParams extends Params {
  LoginUseCaseParams({
    required this.body,
  });

  final Map<String, dynamic> body;
}

class LoginUseCase extends UseCase<UserSession, LoginUseCaseParams> {
  LoginUseCase({
    required this.repository,
  });

  final LoginRepository repository;

  @override
  Future<UserSession> call({LoginUseCaseParams? params}) async {
    http.Response response = await repository.login(params!.body);
    switch (response.statusCode) {
      case 200:
        UserSession session = UserSession.fromJson(json.decode(response.body));
        return session;
      case 403:
        throw UseCaseException(
            json.decode(utf8.decode(response.bodyBytes))["error"]);
      case 401:
        throw UseCaseException(
            json.decode(utf8.decode(response.bodyBytes))["error"]);
      case 404:
        throw UseCaseException(
            json.decode(utf8.decode(response.bodyBytes))["error"]);
      default:
        throw UseCaseException('Algo salio mal con el registro');
    }
  }
}

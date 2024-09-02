import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:survey_app/modules/common/data/use_case/use_case.dart';
import 'package:survey_app/modules/login/data/repository/r_login.dart';

class RegisterUseCaseParams extends Params {
  RegisterUseCaseParams({
    required this.body,
  });

  final Map<String, dynamic> body;
}

class RegisterUseCase
    extends UseCase<Map<String, dynamic>, RegisterUseCaseParams> {
  RegisterUseCase({
    required this.repository,
  });

  final LoginRepository repository;

  @override
  Future<Map<String, dynamic>> call({RegisterUseCaseParams? params}) async {
    http.Response response = await repository.register(params!.body);
    switch (response.statusCode) {
      case 201:
        Map<String, dynamic> message = json.decode(response.body);
        return message;
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

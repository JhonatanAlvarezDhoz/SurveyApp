import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

class BaseRepository {
  final http.Client client;
  final String baseUrl = dotenv.get("baseUrl");

  BaseRepository({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(
    String url,
    Map<String, String>? headers,
  ) async {
    return client.get(Uri.parse("$baseUrl$url"), headers: headers ?? {});
  }

  Future<http.Response> post(
    String url,
    dynamic body,
    Map<String, String>? headers,
  ) async {
    return client.post(Uri.parse("$baseUrl$url"),
        body: body, headers: headers ?? {});
  }
}

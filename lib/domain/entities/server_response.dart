import 'package:http/http.dart';

class ServerResponse {
  ServerResponse({this.statusCode, this.data});

  factory ServerResponse.fromResponse(Response response) {
    final ServerResponse serverResponse = ServerResponse(statusCode: response.statusCode, data: response.body)..response = response;
    return serverResponse;
  }

  final int statusCode;
  final String data;
  Response response;
}
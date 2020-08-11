import 'dart:convert';

import 'package:cc_uffs/models/server_response.dart';
import 'package:cc_uffs/shared/constants.dart';
import 'package:http/http.dart';

class DefaultCommunication {
  static String token;
  static Future<Map<String, String>> get getHeaderWithAuth async {
    final Map<String, dynamic> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    if (token != null && token.isNotEmpty) {
      headers['Cookie'] = 'iPlanetDirectoryPro=$token';
    }
    return headers;
  }

  DefaultCommunication instance() {
    return this;
  }
}

Future<ServerResponse> httpGet(String url, [int counter = 0]) async {
  final Map<String, String> headers =
      await DefaultCommunication.getHeaderWithAuth;
  final Response response =
      await get(url, headers: headers).timeout(HTTP_TIMEOUT, onTimeout: () {
    throw Exception('HTTP_TIMEOUT');
  });

  return ServerResponse.fromResponse(response);
}

Future<ServerResponse> httpPost(String url, Map<String, dynamic> body) async {
  final Map<String, String> headers =
      await DefaultCommunication.getHeaderWithAuth;
  final Response response =
      await post(url, headers: headers, body: json.encode(body))
          .timeout(HTTP_TIMEOUT, onTimeout: () {
    throw Exception('HTTP_TIMEOUT');
  });

  return ServerResponse.fromResponse(response);
}

Future<ServerResponse> httpPut(String url, Map<String, dynamic> body) async {
  final Map<String, String> headers =
      await DefaultCommunication.getHeaderWithAuth;
  final Response response =
      await put(url, headers: headers, body: json.encode(body))
          .timeout(HTTP_TIMEOUT, onTimeout: () {
    throw Exception('HTTP_TIMEOUT');
  });

  return ServerResponse.fromResponse(response);
}

import 'dart:convert';

import 'package:cc_uffs/shared/constants.dart';
import 'package:http/http.dart' as flutter_http;

enum CustomHttpException { HTTP_TIMEOUT }

abstract class http {
  static Future<flutter_http.Response> get(String url,
      {Map<String, String> headers}) async {
    final response = await flutter_http.get(url, headers: headers).timeout(
          HTTP_TIMEOUT,
          onTimeout: () => throw Exception(CustomHttpException.HTTP_TIMEOUT),
        );

    return response;
  }

  static Future<flutter_http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final response = await flutter_http
        .post(url, body: body, headers: headers, encoding: encoding)
        .timeout(HTTP_TIMEOUT, onTimeout: () {
      throw Exception(CustomHttpException.HTTP_TIMEOUT);
    });

    return response;
  }
}

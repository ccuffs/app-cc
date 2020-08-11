library auth_uffs;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// TODO: impelement timeout

bool _isNumeric(string) => num.tryParse(string) != null;

abstract class AuthUffs {
  static Future<Map<String, dynamic>> getUserInfo(
      {String idUffs, String token}) async {
    final res = await http.get(
      'https://id.uffs.edu.br/id/json/users/$idUffs?realm=/',
      headers: {"Cookie": createCookie(token)},
    );

    if (res.statusCode != 200) throw Exception('Could not fetch user data');

    final data = jsonDecode(res.body);

    return data;
  }

  static Future<String> getIdUFFS({String token}) async {
    final res = await http.post(
        'https://id.uffs.edu.br/id/json/users?_action=idFromSession&realm=/',
        body: '{"_action": "idFromSession",\n"realm": "/"}',
        headers: {
          "Cookie": AuthUffs.createCookie(token),
          "JSESSIONID": 'AC7F559BC6F5A11EDE14AC1138B9D9D0; amlbcookie=01',
          "content-type": 'application/json'
        });

    if (res.statusCode != 200)
      throw Exception('Could not get userId from UFFS');

    final parsed = await jsonDecode(res.body);
    return parsed['id'];
  }

  static createCookie(String tokenId) {
    return 'iPlanetDirectoryPro=$tokenId';
  }

  static Future<String> getTokenFromStudentPortal(
      {String authenticator, String password}) async {
    final res = await http.post(
        'https://id.uffs.edu.br/id/json/authenticate?realm=/',
        body:
            '{\"authId\":\"eyAidHlwIjogIkpXVCIsICJhbGciOiAiSFMyNTYiIH0.eyAib3RrIjogInJmc2o3c3NqamhrOXAwaG5mMjNpdjRxcTdvIiwgInJlYWxtIjogImRjPW9wZW5hbSxkYz1mb3JnZXJvY2ssZGM9b3JnIiwgInNlc3Npb25JZCI6ICJBUUlDNXdNMkxZNFNmY3lPWTN3aURPdzNiSkNLRmJka21JOFBaM0hVN0Z5QzRvZy4qQUFKVFNRQUNNREVBQWxOTEFCUXROamcxTmpVNU56WXlNall6TWpZMU56WXdPUUFDVXpFQUFBLi4qIiB9.gyV3J6K-gLZbh7SIYyqjDvI2v3p2HHcPTW-0uysSiAI\",\"template\":\"\",\"stage\":\"DataStore1\",\"header\":\"Entre com seu IdUFFS\",\"callbacks\":[{\"type\":\"NameCallback\",\"output\":[{\"name\":\"prompt\",\"value\":\"IdUFFS ou CPF\"}],\"input\":[{\"name\":\"IDToken1\",\"value\":\"$authenticator\"}]},{\"type\":\"PasswordCallback\",\"output\":[{\"name\":\"prompt\",\"value\":\"Senha\"}],\"input\":[{\"name\":\"IDToken2\",\"value\":\"$password\"}]}]}',
        headers: {
          "accept": "application/json, text/javascript, */*; q=0.01",
          "accept-api-version": "protocol=1.0,resource=2.0",
          "accept-language": "en-US,en;q=0.9",
          "cache-control": "no-cache",
          "content-type": "application/json",
          "sec-fetch-dest": "empty",
          "sec-fetch-mode": "cors",
          "sec-fetch-site": "same-origin",
          "x-nosession": "true",
          "x-password": "anonymous",
          "x-requested-with": "XMLHttpRequest",
          "x-username": "anonymous",
          "mode": "cors",
          "credentials": "include",
          "referrer": "https://id.uffs.edu.br/id/XUI/",
          "referrerPolicy": "no-referrer-when-downgrade",
        });

    // final res = await requestPromise(options) as { data: any };
    if (res.statusCode != 200)
      throw new Exception('Failed to obtain uffs tokenId on student portal');

    final parsedResponse = jsonDecode(res.body).cast<String, String>();

    return parsedResponse['tokenId'];
  }

  static Future<Map<String, dynamic>> authenticate(
      {@required authenticator, @required password}) async {
    String idUffs;

    final token = await AuthUffs.getTokenFromStudentPortal(
      authenticator: authenticator,
      password: password,
    );

    if (_isNumeric(authenticator)) {
      //Need to get idUffs
      idUffs = await AuthUffs.getIdUFFS(token: token);
    } else
      idUffs = authenticator;

    final user = await AuthUffs.getUserInfo(idUffs: idUffs, token: token);

    return user;
  }
}

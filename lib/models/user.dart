import 'dart:convert';

import 'package:cc_uffs/helpers/string.dart';
import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.username,
    @required this.uid,
    @required this.email,
    @required this.personId,
    @required this.name,
    @required this.cpf,
    @required this.tokenId,
    @required this.authenticated,
  });

  factory User.fromJsonServer(dynamic json) {
    Map<String, dynamic> data;

    if (json.runtimeType == String)
      data = jsonDecode(json).cast<String, dynamic>();
    else
      data = json;

    return User(
      username: data['username'],
      uid: data['uid'][0],
      email: data['mail'][0],
      personId: data['pessoa_id'][0],
      name: titleCase(data['cn'][0]),
      cpf: data['employeeNumber'][0],
      authenticated: true,
      tokenId: null,
    );
  }

  factory User.fromJsonLocal(dynamic json) {
    Map<String, dynamic> data;

    if (json.runtimeType == String)
      data = jsonDecode(json).cast<String, dynamic>();
    else
      data = json;

    return User(
      username: data['username'],
      uid: data['uid'],
      email: data['mail'],
      personId: data['personId'],
      name: data['name'],
      cpf: data['cpf'],
      authenticated: data['authenticated'] == 'true' ? true : false,
      tokenId: data['tokenId'],
    );
  }

  String toJson() {
    final Map<String, String> userMap = {
      'username': username,
      'uid': uid,
      'email': email,
      'personId': personId,
      'name': name,
      'cpf': cpf,
      'tokenId': tokenId,
      'authenticated': authenticated.toString(),
    };
    return jsonEncode(userMap);
  }

  final String username;
  final String uid;
  final String email;
  final String personId;
  final String name;
  final String cpf;
  final String tokenId;
  final bool authenticated;
}

import 'dart:convert';

import 'package:cc_uffs/data/helpers/default_request.dart';
import 'package:cc_uffs/domain/entities/server_response.dart';
import 'package:cc_uffs/domain/repositories/authentication_repository.dart' as repository;

const String IDUFFS_TOKEN = 'eyAidHlwIjogIkpXVCIsICJhbGciOiAiSFMyNTYiIH0.eyAib3RrIjogIjF1a3VvMGUybzVoZnRuNHRqNTFjaGdrazcxIiwgInJlYWxtIjogImRjPW9wZW5hbSxkYz1mb3JnZXJvY2ssZGM9b3JnIiwgInNlc3Npb25JZCI6ICJBUUlDNXdNMkxZNFNmY3hJTkJtZzFJM09sR1N1MzhlMGVSeDlXa05fUWhfNElMVS4qQUFKVFNRQUNNREVBQWxOTEFCUXROalE0TWpZMU5UZzNNekl4T0RBMk5UWXlOQUFDVXpFQUFBLi4qIiB9.wulSO8eW8lkBNm6xH06FtwV95ZI4KW6WfC-aiQj5w3s';
class AuthenticationRepository extends repository.AuthenticationRepository {
  AuthenticationRepository();

  @override
  Future<ServerResponse> authenticate({String username, String password}) async {
    final ServerResponse tokenResponse = await getToken(username, password);
    if (tokenResponse.data.isNotEmpty) {
      final String tokenString = json.decode(tokenResponse.data)['tokenId'];
      DefaultCommunication.token = tokenString;
      return getUser(username, tokenString);
    }
    return ServerResponse(statusCode: 404, data: '');
  }

  Future<ServerResponse> getToken(String username, String password) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'authId': IDUFFS_TOKEN,
      'template': '',
      'stage': 'DataStore1',
      'header': 'Entre com seu IdUFFS',
      'callbacks': <Map<String, dynamic>>[
        <String, dynamic>{
          'type': 'NameCallback',
          'output': <Map<String, dynamic>>[
            <String, dynamic>{
              'name': 'prompt',
              'value': 'IdUFFS ou CPF',
            }
          ],
          'input': <Map<String, dynamic>>[
            <String, dynamic>{
              'name': 'IDToken1',
              'value': username,
            }
          ]
        },
        <String, dynamic>{
          'type': 'PasswordCallback',
          'output': <Map<String, dynamic>>[
            <String, dynamic>{
              'name': 'prompt',
              'value': 'Senha',
            }
          ],
          'input': <Map<String, dynamic>>[
            <String, dynamic>{
              'name': 'IDToken2',
              'value': password,
            }
          ]
        }
      ]
    };

    return httpPost('https://id.uffs.edu.br/id/json/authenticate?realm=/', data);
  }

  Future<ServerResponse> getUser(String username, String token) async {
    return httpGet('https://id.uffs.edu.br/id/json/users/$username');
  }
}
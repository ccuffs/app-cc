import 'package:cc_uffs/domain/entities/server_response.dart';

abstract class AuthenticationRepository {
  Future<ServerResponse> authenticate({String username, String password});
}
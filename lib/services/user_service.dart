import 'package:cc_uffs/helpers/local_storage.dart';
import 'package:cc_uffs/models/user.dart';
import 'package:cc_uffs/services/auth_uffs_service.dart';
import 'package:cc_uffs/shared/constants.dart';

enum User_exceptions {
  PASSWORD_USERNAME_WRONG,
}

abstract class UserService {
  static Future<User> tryAutoLogin() async {
    final _user = await LocalStorage.GetString(
      LocalStorageFiles.user,
    );

    if (_user == null) return null;

    // fetch preferences from user too...
    // example: fontSize, fontSpacing, theme, etc...
    // Maybe keep some posts for offline use...

    return User.fromJsonLocal(_user);
  }

  static Future<User> authenticate(
      String authenticator, String password) async {
    try {
      final userMap = await AuthUffs.authenticate(
        authenticator: authenticator,
        password: password,
      );

      final _user = User.fromJsonServer(userMap);

      await LocalStorage.SaveString(
        LocalStorageFiles.user,
        _user.toJson(),
      );

      return _user;
    } catch (error) {
      //find out if it is error on login and password or net, or etc...
      throw Exception(User_exceptions.PASSWORD_USERNAME_WRONG);
    }
  }

  static Future<User> createLocal() async {
    final _user = User(
      authenticated: false,
      cpf: null,
      email: null,
      name: null,
      personId: null,
      tokenId: null,
      uid: null,
      username: null,
    );

    final success = await LocalStorage.SaveString(
      LocalStorageFiles.user,
      _user.toJson(),
    );

    return success ? _user : null;
  }
}

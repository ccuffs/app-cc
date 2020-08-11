import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static Future<bool> SaveString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final success = await preferences.setString(key, value);
    return success;
  }

  static Future<String> GetString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(key)) return null;

    return await preferences.getString(key);
  }
}

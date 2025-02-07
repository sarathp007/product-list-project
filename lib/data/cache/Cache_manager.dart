
import 'package:shared_preferences/shared_preferences.dart';




class CacheManager {
  static late SharedPreferences _preferences;
  static const _keyToken = 'token';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();


  static Future setToken(String value) async {
    await _preferences.setString(_keyToken, value);
    // Optionally, add debug print statement
    // if (kDebugMode) {
    //   print(value);
    // }
  }

  static String getToken() {
    return _preferences.getString(_keyToken) ?? ''; // Returns an empty string if no value is found
  }



}

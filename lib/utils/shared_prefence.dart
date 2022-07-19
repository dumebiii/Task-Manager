import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // static late SharedPreferences _instance;
  // static SharedPreferences get instance => _instance;

  // static Future<SharedPreferences> init() async {
  //   _instance = await SharedPreferences.getInstance();
  //   return _instance;
  // }

  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  static delete(String key) => _prefs.remove(key);
}

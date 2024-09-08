import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  // Save a list of strings
  static Future<void> setListData(List<String> toItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("task", toItems);
  }

  // Save a string value
  static Future<void> setString(String id, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, value);
  }

  // Save an integer value
  static Future<void> setLength(String id, int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(id, length);
  }

  // Get an integer value
  static Future<int> getLength(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(id) ?? 0;
  }

  // Get a string value
  static Future<String> getString(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? '';
  }

  // Save a boolean value
  static Future<void> setBool(String id, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, value);
  }

  // Get a boolean value
  static Future<bool> getBool(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(id) ?? false;
  }
}

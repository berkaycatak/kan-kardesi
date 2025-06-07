import 'package:kan_kardesi/utils/enums/shared_preferences_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<String?> getValue(SharedPreferencesKeyEnums key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.name);
  }

  static Future<bool> setStringValue(
    SharedPreferencesKeyEnums key,
    String value,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key.name, value);
  }

  static Future<bool?> getBoolValue(SharedPreferencesKeyEnums key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key.name);
  }

  static Future<bool> setBoolValue(
    SharedPreferencesKeyEnums key,
    bool value,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key.name, value);
  }
}

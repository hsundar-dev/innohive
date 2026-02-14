import 'package:shared_preferences/shared_preferences.dart';

class Myprefs{
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future setPref(key,value) async {
    init();
    print("User seted");
    await _prefs.setString(key,value);
  }
  static Future getPref(key) async {
    init();
    print("User geted");
    print(_prefs.getString(key));
    return _prefs.getString(key) ?? "NULL";
  }
  static Future delPref(key) async {
    init();
    print("User Deleted");
    await _prefs.remove(key);
  }
}
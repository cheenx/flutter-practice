import 'package:shared_preferences/shared_preferences.dart';

/// 关于SharedPreferences的封装，存储一些本地数据
class LocalStorage {
  static save(String key, value) async {
    final prefs = await getPrefs();
    prefs.setString(key, value);
  }

  static get(String key) async {
    final prefs = await getPrefs();
    return prefs.get(key);
  }

  static remove(String key) async {
    final prefs = await getPrefs();
    prefs.remove(key);
  }

  static Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;
  HiCache._() {
    init();
  }
  static HiCache? _instance;

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance!;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    if (_instance == null) {
      _instance = HiCache._();
    }
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    print("$result");
    if (result != null) {
      return result as T;
    }
    return null;
  }
}

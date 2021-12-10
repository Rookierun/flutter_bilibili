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
}

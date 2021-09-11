import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


Dio dio = Dio();

class Prefs {
  static SharedPreferences prefs;
  static String getString(String key) {
    if (prefs == null) return "";
    var s = prefs.getString(key) ?? "";
    print("get: $key -> $s");
    return s;
  }

  static void setString(String key, String value) {
    print("set: key -> $key | value -> $value");
    if (prefs == null) return;
    prefs.setString(key, value);
  }

  // ignore: missing_return
  static Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}



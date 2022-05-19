import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  String? tokenApp;

  static final MyPreferences _singleton = MyPreferences._internal();

  factory MyPreferences() {
    return _singleton;
  }

  MyPreferences._internal();

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenApp = prefs.getString("token_app") ?? "null";
  }

  Future<bool> saveStringPreference(String name, String save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result = await prefs.setString(name, save);
    return result;
  }

  Future<bool> saveToken(final String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = await prefs.setString("token_app", token);
    tokenApp = token;
    return status;
  }
}

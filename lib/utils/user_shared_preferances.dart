import 'package:shared_preferences/shared_preferences.dart';

class userSharedPreferences {
  static SharedPreferences? _preferences;

  static const String _name = 'name';
  static const String _pin = 'pin';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setName({required String name, required String pin}) async {
    await _preferences!.setString(_name, name);
    await _preferences!.setString(_pin, pin);
  }

  //pengecekan name dan pin
  static String? getName() => _preferences!.getString(_name);
  static String? getPin() => _preferences!.getString(_pin);
}

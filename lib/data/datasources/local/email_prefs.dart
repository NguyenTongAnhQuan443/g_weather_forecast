import 'package:shared_preferences/shared_preferences.dart';

class EmailPrefs {
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weather_email', email);
  }

  static Future<String?> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('weather_email');
  }

  static Future<void> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('weather_email');
  }
}

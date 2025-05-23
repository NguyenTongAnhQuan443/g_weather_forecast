import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/weather_model.dart';

class WeatherHistoryService {
  static const _keyHistory = 'weather_history';
  static const _keyHistoryDate = 'weather_history_date';

  // Lưu weather vào lịch sử
  static Future<void> saveWeatherToHistory(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();

    // Lấy ngày hiện tại
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    // Kiểm tra date trong prefs, nếu khác hôm nay thì xóa hết lịch sử cũ
    final lastDate = prefs.getString(_keyHistoryDate);
    if (lastDate != todayStr) {
      await prefs.remove(_keyHistory);
      await prefs.setString(_keyHistoryDate, todayStr);
    }

    // Lấy danh sách hiện tại
    final list = prefs.getStringList(_keyHistory) ?? [];

    // Convert weather -> Map
    final weatherMap = weather.toJson();
    // Lưu thêm trường searchedAt để hiển thị
    weatherMap['searchedAt'] = DateTime.now().toIso8601String();

    // Check trùng (không lưu lại city đã có)
    final exists = list.any((e) {
      final map = jsonDecode(e);
      return map['cityName'] == weather.cityName && map['localtime'] == weather.localtime;
    });

    if (!exists) {
      list.add(jsonEncode(weatherMap));
      await prefs.setStringList(_keyHistory, list);
    }
  }

  /// Lấy danh sách lịch sử
  static Future<List<WeatherModel>> getTodayWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    final lastDate = prefs.getString(_keyHistoryDate);
    if (lastDate != todayStr) {
      // Nếu không phải hôm nay thì clear luôn
      await prefs.remove(_keyHistory);
      await prefs.setString(_keyHistoryDate, todayStr);
      return [];
    }
    final list = prefs.getStringList(_keyHistory) ?? [];
    return list.map((e) => WeatherModel.fromJson(jsonDecode(e))).toList();
  }
}

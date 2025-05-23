import 'dart:convert';
import 'package:g_weather_forecast/core/config/api_config.dart';
import 'package:g_weather_forecast/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  Future<WeatherModel> fetchCurrentWeather(String query) async {
    final url =
        '${ApiConfig.weatherBaseUrl}${ApiConfig.currentWeather}?key=${ApiConfig.weatherApiKey}&q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

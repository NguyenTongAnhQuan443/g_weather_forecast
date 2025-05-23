import 'dart:convert';
import 'package:g_weather_forecast/core/config/api_config.dart';
import 'package:g_weather_forecast/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

import '../../models/forecast_day_model.dart';

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

  Future<List<ForecastDayModel>> fetchForecast(String query, int days) async {
    final url =
        '${ApiConfig.weatherBaseUrl}${ApiConfig.forecastWeather}?key=${ApiConfig.weatherApiKey}&q=$query&days=$days';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['forecast']['forecastday'];
      return list.map((e) => ForecastDayModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}

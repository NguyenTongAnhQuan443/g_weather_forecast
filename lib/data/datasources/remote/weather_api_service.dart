import 'dart:convert';
import 'package:g_weather_forecast/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  static const String _apiKey = 'db6cfe8cb4c5446893015445252305';
  static const String _baseUrl = 'http://api.weatherapi.com/v1';

  Future<WeatherModel> fetchCurrentWeather(String query) async {
    final url = '$_baseUrl/current.json?key=$_apiKey&q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

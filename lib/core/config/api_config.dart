import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get weatherApiKey => dotenv.env['WEATHER_API_KEY'] ?? '';
  static String get weatherBaseUrl => dotenv.env['WEATHER_BASE_URL'] ?? '';
  static const String currentWeather = '/current.json';
  static const String forecastWeather = '/forecast.json';
}

import '../datasources/remote/weather_api_service.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherApiService _apiService;

  WeatherRepository(this._apiService);

  Future<WeatherModel> getCurrentWeather(String query) {
    return _apiService.fetchCurrentWeather(query);
  }
}

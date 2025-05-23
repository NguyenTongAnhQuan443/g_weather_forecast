import '../datasources/remote/weather_api_service.dart';
import '../models/forecast_day_model.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherApiService _apiService;

  WeatherRepository(this._apiService);

  Future<WeatherModel> getCurrentWeather(String query) {
    return _apiService.fetchCurrentWeather(query);
  }

  Future<List<ForecastDayModel>> getForecast(String query, int days) {
    return _apiService.fetchForecast(query, days);
  }
}

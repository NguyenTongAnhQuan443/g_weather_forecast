import 'package:flutter/material.dart';
import '../data/models/weather_model.dart';
import '../data/repositories/weather_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final WeatherRepository _weatherRepository;

  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;

  HomeViewModel(this._weatherRepository);

  Future<void> searchWeather(String query) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      weather = await _weatherRepository.getCurrentWeather(query);
    } catch (e) {
      errorMessage = 'Không tìm thấy hoặc lỗi kết nối!';
      weather = null;
    }
    isLoading = false;
    notifyListeners();
  }
}

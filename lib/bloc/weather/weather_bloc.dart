import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../data/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather(event.city);
      final forecast = await weatherRepository.getForecast(event.city, event.forecastDays + 1);
      emit(WeatherLoaded(weather, forecast));
    } catch (e) {
      emit(WeatherError('Không tìm thấy hoặc lỗi kết nối!'));
    }
  }
}

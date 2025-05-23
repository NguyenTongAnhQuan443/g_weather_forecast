import 'package:equatable/equatable.dart';
import '../../data/models/weather_model.dart';
import '../../data/models/forecast_day_model.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final List<ForecastDayModel> forecastDays;

  WeatherLoaded(this.weather, this.forecastDays);

  @override
  List<Object?> get props => [weather, forecastDays];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

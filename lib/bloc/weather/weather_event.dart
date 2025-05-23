import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;
  final int forecastDays;

  FetchWeatherEvent(this.city, {this.forecastDays = 4});

  @override
  List<Object?> get props => [city, forecastDays];
}

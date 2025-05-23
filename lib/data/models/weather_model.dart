class WeatherModel {
  final String cityName;
  final String region;
  final String country;
  final double temperatureC;
  final int humidity;
  final double windKph;
  final String conditionText;
  final String iconUrl;
  final String localtime;

  WeatherModel({
    required this.cityName,
    required this.region,
    required this.country,
    required this.temperatureC,
    required this.humidity,
    required this.windKph,
    required this.conditionText,
    required this.iconUrl,
    required this.localtime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('cityName')) {
      return WeatherModel(
        cityName: json['cityName'] ?? '',
        region: json['region'] ?? '',
        country: json['country'] ?? '',
        temperatureC: (json['temperatureC'] ?? 0.0).toDouble(),
        humidity: json['humidity'] ?? 0,
        windKph: (json['windKph'] ?? 0.0).toDouble(),
        conditionText: json['conditionText'] ?? '',
        iconUrl: json['iconUrl'] ?? '',
        localtime: json['localtime'] ?? '',
      );
    }

    // Nếu json là kiểu trả về từ API
    return WeatherModel(
      cityName: json['location']['name'] ?? '',
      region: json['location']['region'] ?? '',
      country: json['location']['country'] ?? '',
      temperatureC: (json['current']['temp_c'] ?? 0.0).toDouble(),
      humidity: json['current']['humidity'] ?? 0,
      windKph: (json['current']['wind_kph'] ?? 0.0).toDouble(),
      conditionText: json['current']['condition']['text'] ?? '',
      iconUrl: "https:${json['current']['condition']['icon'] ?? ''}",
      localtime: json['location']['localtime'] ?? '',
    );
  }

  // toJson để convert về map
  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'region': region,
      'country': country,
      'temperatureC': temperatureC,
      'humidity': humidity,
      'windKph': windKph,
      'conditionText': conditionText,
      'iconUrl': iconUrl,
      'localtime': localtime,
    };
  }
}

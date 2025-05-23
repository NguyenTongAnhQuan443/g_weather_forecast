class ForecastDayModel {
  final String date;
  final double avgTempC;
  final double maxWindKph;
  final double avgHumidity;
  final String conditionText;
  final String iconUrl;

  ForecastDayModel({
    required this.date,
    required this.avgTempC,
    required this.maxWindKph,
    required this.avgHumidity,
    required this.conditionText,
    required this.iconUrl,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json['date'],
      avgTempC: (json['day']['avgtemp_c'] ?? 0.0).toDouble(),
      maxWindKph: (json['day']['maxwind_kph'] ?? 0.0).toDouble(),
      avgHumidity: (json['day']['avghumidity'] ?? 0.0).toDouble(),
      conditionText: json['day']['condition']['text'] ?? '',
      iconUrl: "https:${json['day']['condition']['icon'] ?? ''}",
    );
  }
}

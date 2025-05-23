import 'package:flutter/material.dart';
import '../../data/models/forecast_day_model.dart';
import '../../core/constants/app_styles.dart';

// Card hiển thị từng ngày dự báo trong ForecastRow
class ForecastCard extends StatelessWidget {
  final ForecastDayModel model;
  const ForecastCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.grayapp,
      child: Container(
        width: 170,
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('(${model.date})', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textWhite)),
            const SizedBox(height: 10),
            Image.network(model.iconUrl, width: 55, height: 55),
            const SizedBox(height: 10),
            Text('Temp: ${model.avgTempC}°C', style: TextStyle(color: AppColors.textWhite)),
            Text('Wind: ${model.maxWindKph} KM/H', style: TextStyle(color: AppColors.textWhite)),
            Text('Humidity: ${model.avgHumidity}%', style: TextStyle(color: AppColors.textWhite)),
            Text(
              model.conditionText,
              style: const TextStyle(color: AppColors.textWhite, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

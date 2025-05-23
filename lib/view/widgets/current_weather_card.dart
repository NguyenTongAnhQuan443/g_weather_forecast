import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../core/constants/app_styles.dart';
import 'marquee_text.dart';

// Widget để hiển thị thông tin thời tiết hiện tại
class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {

          // Nếu là web, chia ra 2 cột: trái info, phải icon + trạng thái
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Tên thành phố + thời gian
                      Text('${weather.cityName} (${weather.localtime})',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        'Temperature: ${weather.temperatureC}°C\n'
                        'Wind: ${weather.windKph} M/S\n'
                        'Humidity: ${weather.humidity}%',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Icon + mô tả trạng thái
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Column(
                    children: [
                      Image.network(weather.iconUrl, width: 55, height: 55),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 150,
                        child: Text(
                          weather.conditionText,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {

            // Nếu là mobile thì xếp dọc
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${weather.cityName} (${weather.localtime})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Temperature: ${weather.temperatureC}°C\n'
                        'Wind: ${weather.windKph} M/S\n'
                        'Humidity: ${weather.humidity}%',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(weather.iconUrl, width: 55, height: 55),
                        const SizedBox(height: 4),
                        SizedBox(
                            width: 80,
                            child: MarqueeText(text: weather.conditionText)),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

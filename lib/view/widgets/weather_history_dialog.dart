import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/weather_model.dart';

// widget hiển thị lịch sử tìm kiếm thời tiết
class WeatherHistoryDialog extends StatelessWidget {
  final List<WeatherModel> history;
  const WeatherHistoryDialog({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text("Today's Search History"),
      content: SizedBox(
        width: 300,
        height: 350,
        child: history.isEmpty
            ? Text('No search history today.')
            : ListView.builder(
          itemCount: history.length,
          itemBuilder: (ctx, i) {
            final item = history[i];
            return ListTile(
              leading: Image.network(item.iconUrl, width: 32, height: 32),
              title: Text(item.cityName),
              subtitle: Text(
                'Temp: ${item.temperatureC}°C\n'
                    'Time: ${item.localtime}',
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.grayapp,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 45),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}

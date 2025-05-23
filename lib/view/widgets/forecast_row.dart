import 'package:flutter/material.dart';
import '../../data/models/forecast_day_model.dart';
import 'forecast_card.dart';

// Widget hiển thị danh sách các ngày dự báo và nút See more
class ForecastRow extends StatelessWidget {
  final List<ForecastDayModel> forecastList;
  final bool canShowMore;
  final VoidCallback onSeeMore;

  const ForecastRow({
    Key? key,
    required this.forecastList,
    required this.canShowMore,
    required this.onSeeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(
            forecastList.length,
                (index) => ForecastCard(model: forecastList[index]),
          ),
        ),
        if (canShowMore)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: onSeeMore,
                child: const Text('See more', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

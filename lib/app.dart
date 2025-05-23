import 'package:flutter/material.dart';

import 'core/constants/app_styles.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Dashboard', style: TextStyle(color: AppColors.textWhite),),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildSearchPanel()),
                Expanded(flex: 3, child: _buildWeatherPanel()),
              ],
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchPanel(),
                _buildWeatherPanel(),
              ],
            ),
          );
        },
      ),
      backgroundColor: AppColors.background,
    );
  }

  Widget _buildSearchPanel() => Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Enter a City Name',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: 'E.g., New York, London, Tokyo',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Search', style: TextStyle(color: AppColors.textWhite),),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('or'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Use Current Location',style: TextStyle(color: AppColors.textWhite),),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45),
            backgroundColor: AppColors.grayapp,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          ),
        ),
      ],
    ),
  );

  Widget _buildWeatherPanel() => Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'London (2023-06-19)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temperature: 18.71°C\nWind: 4.31 M/S\nHumidity: 76%',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Icon + trạng thái
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,20,0),
                child: Column(
                  children: const [
                    Icon(Icons.cloud, color: Colors.white, size: 50),
                    SizedBox(height: 8),
                    Text(
                      'Moderate rain',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          '4-Day Forecast',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        const SizedBox(height: 16),
        _buildForecastRow(),
      ],
    ),
  );

  Widget _buildForecastRow() => Wrap(
    spacing: 20,
    runSpacing: 20,
    children: List.generate(4, (index) => _buildForecastCard(index)),
  );

  Widget _buildForecastCard(int i) {
    final dates = ['2023-06-20', '2023-06-21', '2023-06-22', '2023-06-23'];
    final temps = ['17.64', '16.78', '18.20', '17.08'];
    final winds = ['0.73', '2.72', '1.49', '0.9'];
    final humidities = ['70', '83', '72', '89'];
    final icons = [
      Icons.cloud,
      Icons.wb_sunny,
      Icons.flash_on,
      Icons.water,
    ];
    return Card(
      color: AppColors.grayapp,
      child: Container(
        width: 170,
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '(${dates[i]})',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.textWhite),
            ),
            const SizedBox(height: 10),
            Icon(icons[i], size: 32, color: AppColors.textWhite),
            const SizedBox(height: 10),
            Text('Temp: ${temps[i]}°C',style: TextStyle(color: AppColors.textWhite),),
            Text('Wind: ${winds[i]} M/S',style: TextStyle(color: AppColors.textWhite),),
            Text('Humidity: ${humidities[i]}%',style: TextStyle(color: AppColors.textWhite),),
          ],
        ),
      ),
    );
  }
}

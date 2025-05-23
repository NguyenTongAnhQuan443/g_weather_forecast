import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../bloc/weather/weather_state.dart';
import '../../core/constants/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _AppState();
}

class _AppState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeatherEvent(city));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Dashboard',
          style: TextStyle(
              color: AppColors.textWhite, fontWeight: FontWeight.bold),
        ),
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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'E.g., New York, London, Tokyo',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey[400]!),
                ),
              ),
              onSubmitted: (value) => _searchWeather(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchWeather,
              child: const Text(
                'Search',
                style: TextStyle(color: AppColors.textWhite),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
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
              child: const Text(
                'Use Current Location',
                style: TextStyle(color: AppColors.textWhite),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: AppColors.grayapp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ],
        ),
      );

  Widget _buildWeatherPanel() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {

        // 1. Khi đang tải (WeatherLoading)
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Khi thành công (WeatherLoaded)
        if (state is WeatherLoaded) {
          final weather = state.weather;
          return Padding(
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 800) {
                        // Layout cho web
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weather.cityName +
                                        ' (${weather.localtime})',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Temperature: ${weather.temperatureC}°C\n'
                                    'Wind: ${weather.windKph} M/S\n'
                                    'Humidity: ${weather.humidity}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Column(
                                children: [
                                  Image.network(
                                    weather.iconUrl,
                                    width: 55,
                                    height: 55,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      weather.conditionText,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Layout cho mobile
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weather.cityName + ' (${weather.localtime})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Temperature: ${weather.temperatureC}°C\n'
                                    'Wind: ${weather.windKph} M/S\n'
                                    'Humidity: ${weather.humidity}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      weather.iconUrl,
                                      width: 55,
                                      height: 55,
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: 80,
                                      child: _buildMarqueeText(
                                          weather.conditionText),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
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
        }

        // 3. Khi có lỗi (WeatherError)
        if (state is WeatherError) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        // 4. Trạng thái mặc định (WeatherInitial)
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Có thể để trống hoặc cho thông điệp chờ tìm kiếm
            ],
          ),
        );
      },
    );
  }

  Widget _buildMarqueeText(String text) {
    return SizedBox(
      height: 20,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Tự động cuộn lại khi kết thúc
          if (notification is ScrollEndNotification) {
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            });
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

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
            Text(
              'Temp: ${temps[i]}°C',
              style: TextStyle(color: AppColors.textWhite),
            ),
            Text(
              'Wind: ${winds[i]} M/S',
              style: TextStyle(color: AppColors.textWhite),
            ),
            Text(
              'Humidity: ${humidities[i]}%',
              style: TextStyle(color: AppColors.textWhite),
            ),
          ],
        ),
      ),
    );
  }
}

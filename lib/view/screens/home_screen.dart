import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../bloc/weather/weather_event.dart';
import '../../bloc/weather/weather_state.dart';
import '../../core/constants/app_styles.dart';
import '../../data/datasources/local/weather_history_service.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/forecast_row.dart';
import '../widgets/search_panel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // State variables
  int _forecastDisplayCount = 4;
  String _lastSearchedCity = '';

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Hàm lấy vị trí hiện tại
  Future<void> _useCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng bật GPS trên thiết bị!')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bạn chưa cấp quyền vị trí!')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quyền vị trí bị cấm vĩnh viễn!')),
      );
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String? city;
      try {
        final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (placemarks.isNotEmpty) {
          city = placemarks.first.locality ??
              placemarks.first.administrativeArea ??
              '';
        }
      } catch (e) {
        city = null;
      }

      if (city != null && city.isNotEmpty) {
        _searchController.text = city;
        _searchWeather();
      } else {

        // Nếu không resolve được city, truyền luôn lat,lng
        String latlng = '${pos.latitude},${pos.longitude}';
        context.read<WeatherBloc>().add(FetchWeatherEvent(latlng, forecastDays: 10));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lấy thời tiết theo GPS!')),
        );
      }
    } catch (e) {
      print('Lỗi khi lấy vị trí: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể lấy vị trí hiện tại!')),
      );
    }
  }



  // Xử lý tìm kiếm thời tiết cho thành phố
  void _searchWeather() {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      _lastSearchedCity = city;
      _forecastDisplayCount = 4;
      context
          .read<WeatherBloc>()
          .add(FetchWeatherEvent(city, forecastDays: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Weather Dashboard',
      //     style: TextStyle(
      //         color: AppColors.textWhite, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: AppColors.primary,
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        title: const Text(
          'Weather Dashboard',
          style: TextStyle(
              color: AppColors.textWhite, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_horiz, color: AppColors.textWhite),
            onSelected: (value) async {
              if (value == 1) {
                // Ở đây mở dialog lịch sử
                final history = await WeatherHistoryService.getTodayWeatherHistory();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Lịch sử tìm kiếm hôm nay'),
                    content: SizedBox(
                      width: 300,
                      height: 350,
                      child: history.isEmpty
                          ? Text('Chưa có lịch sử tìm kiếm nào trong ngày.')
                          : ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (ctx, i) {
                          final item = history[i];
                          return ListTile(
                            leading: Image.network(item.iconUrl, width: 32, height: 32),
                            title: Text(item.cityName),
                            subtitle: Text(
                              'Nhiệt độ: ${item.temperatureC}°C\n'
                                  'Thời gian: ${item.localtime}',
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Đóng'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text('Xem lịch sử hôm nay'),
              ),
            ],
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          // Responsive layout: Hiển thị khác nhau cho mobile và web
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Panel tìm kiếm bên trái
                Expanded(
                  flex: 1,
                  child: SearchPanel(
                    controller: _searchController,
                    onSearch: _searchWeather,
                    onUseCurrentLocation: _useCurrentLocation,
                  ),
                ),

                // Panel thông tin bên phải, có scroll
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: _buildWeatherPanel(),
                  ),
                ),
              ],
            );
          }

          // Nếu là mobile thì xếp dọc
          return SingleChildScrollView(
            child: Column(
              children: [
                SearchPanel(
                  controller: _searchController,
                  onSearch: _searchWeather,
                  onUseCurrentLocation: _useCurrentLocation,
                ),
                _buildWeatherPanel(),
              ],
            ),
          );
        },
      ),
      backgroundColor: AppColors.background,
    );
  }

  // Panel hiển thị thông tin thời tiết
  Widget _buildWeatherPanel() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is WeatherLoaded) {
          final weather = state.weather;
          final allForecast = state.forecastDays;
          final forecastList =
              allForecast.skip(1).take(_forecastDisplayCount).toList();
          final canShowMore = _forecastDisplayCount < (allForecast.length - 1);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget hiển thị weather hiện tại
                CurrentWeatherCard(weather: weather),
                const SizedBox(height: 30),

                // Tiêu đề forecast
                const Text('4-Day Forecast',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                const SizedBox(height: 16),

                // Widget hiển thị danh sách forecast + nút "See more"
                ForecastRow(
                  forecastList: forecastList,
                  canShowMore: canShowMore,
                  onSeeMore: () {
                    setState(() {
                      _forecastDisplayCount += 3;
                    });
                  },
                ),
              ],
            ),
          );
        }

        // Nếu lỗi, hiển thị báo lỗi
        if (state is WeatherError) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18)),
          );
        }

        // Trạng thái mặc định
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        );
      },
    );
  }
}

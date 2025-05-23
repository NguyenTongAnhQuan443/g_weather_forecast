import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Thêm dòng này

import 'bloc/weather/weather_bloc.dart';
import 'core/constants/app_styles.dart';
import 'data/datasources/remote/weather_api_service.dart';
import 'data/repositories/weather_repository.dart';
import 'view/screens/home_screen.dart';

Future<void> main() async {
  // await dotenv.load(fileName: "assets/.env");
  // print(dotenv.env['WEATHER_API_KEY']);
  final weatherRepository = WeatherRepository(WeatherApiService());
  runApp(
    BlocProvider(
      create: (_) => WeatherBloc(weatherRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G-Weather-Forecast - GOLDEN OWL SOLUTIONS',
      theme: ThemeData(
        fontFamily: 'Rubik',
        colorScheme: const ColorScheme.light(),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

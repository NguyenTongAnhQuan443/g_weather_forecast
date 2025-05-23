import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G-Weather-Forecast - GOLDEN OWL SOLUTIONS',
      home: const App(),
      debugShowCheckedModeBanner: false,
    );
  }
}

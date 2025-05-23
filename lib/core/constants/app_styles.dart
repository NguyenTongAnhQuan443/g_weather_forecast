import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5372F0);
  static const secondary = Color(0xFFBFCFFA);
  static const background = Color(0xFFE3F2FD);
  static const grayapp = Color(0xFF6C757D);
  static const textWhite = Colors.white;
}

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    fontFamily: 'Rubik',
  );
  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textWhite,
    fontFamily: 'Rubik',
  );
}

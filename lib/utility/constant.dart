import 'package:flutter/material.dart';

const String appName = 'MatriStation';
const String baseURL = "https:///";
const Color primaryColor = Colors.pink ;
const Color iconColor = Colors.green;


class MatriColors {
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color accentRed = Color(0xFFEF5350);
  static const Color secondaryRed = Color(0xFFE57373);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color lightRed = Color(0xFFFFEBEE);
  static const Color mediumGreen = Color(0xFFC8E6C9);
  static const Color mediumRed = Color(0xFFFFCDD2);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color white = Colors.white;
  static const Color greyLight = Color(0xFFB0BEC5);
  static const Color greyMedium = Color(0xFF78909C);
  static const Color greyDark = Color(0xFF546E7A);
  static const Color greyDarker = Color(0xFF455A64);
  static const Color blackShadow = Color(0x8A000000);
  static const List<Color> slide1Gradient = [lightRed, white];
  static const List<Color> slide2Gradient = [mediumGreen, white];
  static const List<Color> slide3Gradient = [mediumRed, white];
  static const List<Color> defaultGradient = [lightGreen, white];
  static Color primaryShadow = primaryGreen.withOpacity(0.5);
  static Color accentShadow = accentRed.withOpacity(0.4);
  static Color glowShadow = primaryGreen.withOpacity(0.4);
  static Color subtleShadow = Colors.black.withOpacity(0.1);
}

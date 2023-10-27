import 'package:flutter/material.dart';

class AppColorLight {
  static const Color primary = Color(0xFF5790DF);
  static const Color secondary = Color(0xFFE6EEFA);
  static const Color surface = Color(0xFFE6EEFA);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);
  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);
  static const Color error = Colors.red;
  static const Color onError = Color(0xFFFFFFFF);
}

class AppColorDark {
  static const Color primary = Color(0xFF5790DF);
  static const Color secondary = Color(0xFFE6EEFA);
  static  Color surface = Colors.grey[800]!;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFF121212);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color error = Colors.red;
  static const Color onError = Color(0xFFFFFFFF);
}
class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}

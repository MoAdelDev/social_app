import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/core/style/colors.dart';
import 'package:social_app/core/style/fonts.dart';

class AppThemes {
  static ThemeData lightTheme() => ThemeData(
        splashColor: AppColorLight.primary,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColorLight.background,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColorLight.primary,
            statusBarBrightness: Brightness.light
          ),
        ),
        colorScheme: const ColorScheme(
          primary: AppColorLight.primary,
          background: AppColorLight.background,
          secondary: AppColorLight.secondary,
          error: AppColorLight.error,
          surface: AppColorLight.surface,
          onSurface: AppColorLight.onSurface,
          onPrimary: AppColorLight.onPrimary,
          onSecondary: AppColorLight.onSecondary,
          onError: AppColorLight.onError,
          onBackground: AppColorLight.onBackground,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 50.0,
            fontFamily: AppFonts.bold,
            color: AppColorLight.onBackground,
          ),
          titleMedium: TextStyle(
            fontSize: 40.0,
            fontFamily: AppFonts.bold,
            color: AppColorLight.onBackground,
          ),
          titleSmall: TextStyle(
            fontSize: 30.0,
            fontFamily: AppFonts.semiBold,
            color: AppColorLight.onBackground,
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
          bodySmall: TextStyle(
            fontSize: 16.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
          displayLarge: TextStyle(
            fontSize: 16.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
          displayMedium: TextStyle(
            fontSize: 14.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
          displaySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: AppFonts.regular,
            color: AppColorLight.onBackground,
          ),
        ),
      );

  static ThemeData darkTheme() => ThemeData(
        splashColor: AppColorDark.primary,
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: AppColorDark.background,
            elevation: 0.0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: AppColorDark.primary)),
        colorScheme: const ColorScheme(
          primary: AppColorDark.primary,
          background: AppColorDark.background,
          secondary: AppColorDark.secondary,
          error: AppColorDark.error,
          surface: AppColorDark.surface,
          onSurface: AppColorDark.onSurface,
          onPrimary: AppColorDark.onPrimary,
          onSecondary: AppColorDark.onSecondary,
          onError: AppColorDark.onError,
          onBackground: AppColorDark.onBackground,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 50.0,
            fontFamily: AppFonts.bold,
            color: AppColorDark.onBackground,
          ),
          titleMedium: TextStyle(
            fontSize: 40.0,
            fontFamily: AppFonts.bold,
            color: AppColorDark.onBackground,
          ),
          titleSmall: TextStyle(
            fontSize: 30.0,
            fontFamily: AppFonts.semiBold,
            color: AppColorDark.onBackground,
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
          bodySmall: TextStyle(
            fontSize: 16.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
          displayLarge: TextStyle(
            fontSize: 16.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
          displayMedium: TextStyle(
            fontSize: 14.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
          displaySmall: TextStyle(
            fontSize: 12.0,
            fontFamily: AppFonts.regular,
            color: AppColorDark.onBackground,
          ),
        ),
      );
}

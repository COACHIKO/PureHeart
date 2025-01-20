import 'package:flutter/material.dart';

class AqarTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: AppTheme.background,
    fontFamily: 'Tajawal',
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: AppTheme.white1,
      titleTextStyle: const TextStyle(
        color: AppTheme.white1,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.white1,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: BorderSide(color: AppTheme.primaryColor),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppTheme.primaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTheme.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: AppTheme.grey),
      hintStyle: TextStyle(color: AppTheme.grey),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppTheme.lightGrey,
      disabledColor: AppTheme.grey,
      selectedColor: AppTheme.primaryColor,
      secondarySelectedColor: AppTheme.secondaryColor,
      labelStyle: const TextStyle(color: AppTheme.black),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
  );
}

class AppTheme {
  static const Color primaryColor = Color(0xFF19206B);
  static const Color primaryLightColor = Color(0xffF3F3FA);
  static const Color secondaryColor = Color(0xFF1C1D6F);
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFCFCFC);
  static const Color white1 = Color(0xFFFFFFFF);
  static const Color background = Color(0xFF010535);
  static const Color grey = Color(0xFF909090);
  static const Color lightGrey = Color(0xFFF2F2F2);
  static const Color red = Color(0xFFFD0E0E);
  static const Color blue = Color(0xFF0030FF);

  static const LinearGradient gradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      blue,
      secondaryColor,
    ],
  );
}

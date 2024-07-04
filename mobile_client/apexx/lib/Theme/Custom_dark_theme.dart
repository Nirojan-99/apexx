import 'package:apexx/Theme/Material_color.dart';
import 'package:flutter/material.dart';

ThemeData customDarkTheme() {
  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    appBarTheme: const AppBarTheme(
      color: Color(0xFF0F1E3D),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 25,
          fontFamily: "open sans"),
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: buildMaterialColor(
      const Color(0xFF0F1E3D),
    )).copyWith(
      secondary: buildMaterialColor(
        const Color(0xffEEB51D),
      ),
    ),
    splashColor: const Color(0xFF0F1E3D),
    brightness: Brightness.light,
    textTheme: const TextTheme(),
    scaffoldBackgroundColor: const Color(0xFF0F1E3D),
    iconTheme: const IconThemeData(color: Colors.white)
  );
}
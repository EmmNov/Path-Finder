import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData.light(useMaterial3: false).copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color.fromARGB(255, 0, 125, 228)),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ));
}

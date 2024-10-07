import 'package:flutter/material.dart';
import 'package:movies_app/core/config/color_palette.dart';

class ApplicationThemeManager {
  static var darkTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        color: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: ColorPalette.primaryColor,
        ),
        iconTheme: IconThemeData(
          color: ColorPalette.primaryColor,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Color(0xFF1A1A1A),
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: ColorPalette.primaryColor, size: 30),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: ColorPalette.primaryColor,
      ),
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    ),
  );
}

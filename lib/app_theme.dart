import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xff5D9CEC);
  static const backgroundLight = Color(0xffDFECDB);
  static const backgroundDark = Color(0xff060E1E);
  static const black = Color(0xff363636);
  static const white = Color(0xffFFFFFF);
  static const grey = Color(0xffC8C9CB);

  static const green = Color(0xff61E757);

  static const red = Color(0xffEC4B4B);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        size: 40,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30,
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 0,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: white,width: 4))
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primary
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        // fontWeight: FontWeight.bold,
      ),
    )
  );
  static ThemeData darkTheme = ThemeData();
  
}
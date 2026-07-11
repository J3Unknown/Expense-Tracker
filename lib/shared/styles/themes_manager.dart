import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme(){
  return ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.backgroundColor,
      scrolledUnderElevation: 0,
      surfaceTintColor: ColorsManager.transparent,
      iconTheme: IconThemeData(
        color: ColorsManager.white
      )
    ),
    primaryColor: ColorsManager.primaryColor,

    cardTheme: CardThemeData(
      color: ColorsManager.primaryColor
    ),

    textTheme: TextTheme(
      displaySmall: TextStyle(color: ColorsManager.white),
      titleMedium: TextStyle(color: ColorsManager.white),
      headlineSmall: TextStyle(color: ColorsManager.white),
      headlineLarge: TextStyle(color: ColorsManager.white),
      headlineMedium: TextStyle(color: ColorsManager.white),
    )
  );
}

ThemeData lightTheme(){
  return ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.white,
      scrolledUnderElevation: 0,
      surfaceTintColor: ColorsManager.transparent,
      iconTheme: IconThemeData(
        color: ColorsManager.black
      )
    ),
    primaryColor: ColorsManager.lightPrimaryColor,

    cardTheme: CardThemeData(
      color: ColorsManager.lightPrimaryColor
    ),

    textTheme: TextTheme(
      displaySmall: TextStyle(color: ColorsManager.black),
      titleMedium: TextStyle(color: ColorsManager.black),
      headlineSmall: TextStyle(color: ColorsManager.black),
      headlineLarge: TextStyle(color: ColorsManager.black),
      headlineMedium: TextStyle(color: ColorsManager.black),
    )
  );
}
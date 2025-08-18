import 'package:expense_tracker/shared/styles/colors_manager.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme(){
  return ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    appBarTheme: AppBarTheme(
      color: ColorsManager.backgroundColor,
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
      headlineLarge: TextStyle(color: ColorsManager.white),
      headlineMedium: TextStyle(color: ColorsManager.white),
    )
  );
}
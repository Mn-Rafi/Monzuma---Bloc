import 'package:flutter/material.dart';
import 'package:money_manager_app/customs/custom_text_and_color.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      primaryIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(bodyText1: customTextStyleOne(color: Colors.white)),
      primarySwatch: Colors.grey,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: customTextStyleOne(fontSize: 20, color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.grey.shade900);

  static final lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      appBarTheme: AppBarTheme(
        foregroundColor: firstBlack,
        actionsIconTheme: const IconThemeData(color: firstBlack),
        titleTextStyle: customTextStyleOne(fontSize: 20, color: firstBlack),
      ),
      scaffoldBackgroundColor: Colors.white);
}

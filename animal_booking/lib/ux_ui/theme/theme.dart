import 'package:flutter/material.dart';


class AppTheme{

  static Color primary= Colors.lightGreenAccent.shade400;

  static ThemeData myAppTheme=ThemeData.dark().copyWith(
    primaryColor: primary,
    

    appBarTheme: AppBarTheme(color:primary,elevation:10),
  );

}
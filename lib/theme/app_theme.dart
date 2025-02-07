import 'package:flutter/material.dart';

import 'colors.dart';

@immutable
class AppTheme{
  static const colors = AppColors();

  const AppTheme._();
  static ThemeData define(){
    return ThemeData(
      fontFamily: "SGRegular",
      primaryColor: const Color(0xFF014D69),
      hintColor: Color(Colors.green as int),
      focusColor: Color(Colors.deepPurple as int)
    );
  }
}
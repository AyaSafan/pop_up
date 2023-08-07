import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildCustomTheme();

class MyColors {
  static const Color red = Color(0xFFe60000);
  static const Color lightRed = Color(0xFFfbebec);
  static const Color black26 = Color(0xFF262626);
}

ColorScheme myColorScheme = const ColorScheme(
  primary: MyColors.red,
  secondary: MyColors.red,
  surface: Colors.white,
  background: Colors.white,
  error: MyColors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: MyColors.black26,
  onBackground: MyColors.black26,
  onError: MyColors.black26,
  brightness: Brightness.light,
);

ThemeData _buildCustomTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: MyColors.red,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.red,
          //textTheme: ButtonTextTheme.primary,
          //height: 50,
          minimumSize: const Size.fromHeight(50),
          //padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )
      )
    ),
    textTheme: _buildCustomTextTheme(base.textTheme),
    primaryTextTheme: _buildCustomTextTheme(base.primaryTextTheme), colorScheme: myColorScheme.copyWith(error: MyColors.red),
  );
}

TextTheme _buildCustomTextTheme(TextTheme base) {
  return base
      .copyWith(
    caption: base.caption?.copyWith(
      color: Colors.black
    ),
    button: base.button?.copyWith(
      letterSpacing: 0.7
    )
  ).apply(
    fontFamily: 'Lato',
  );
}


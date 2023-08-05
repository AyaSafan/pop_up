import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildCustomTheme();

class MyColors {

  static const Color purple =  Color(0xFF6249C5);
  static const  Color lilac =  Color(0xFFDED8F3);
  static const Color blue = Color(0xFF007BFF);
  static const Color lightBlue = Color(0xFFCCE5FF);
  static const Color red = Color(0xFFDC3545);
  static const Color lightRed = Color(0xFFfbebec);
  static const Color yellow = Color(0xFFFFA500);
  static const Color lightYellow = Color(0xFFffedcc);
  static const Color black26 = Color(0xFF262626);
}

ColorScheme myColorScheme = const ColorScheme(
  primary: MyColors.purple,
  secondary: MyColors.purple,
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
    colorScheme: myColorScheme,
    toggleableActiveColor: MyColors.purple,
    primaryColor: MyColors.purple,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    errorColor: MyColors.red,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: MyColors.purple,
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
    primaryTextTheme: _buildCustomTextTheme(base.primaryTextTheme),
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


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// generate color scheme using this
const Color backgroundColor = Colors.white;
const Color primaryColor = Color(0xff0081C9);
const Color secondaryColor = Color(0xff5BC0F8);
const Color tertiaryColor = Color(0xff86E5FF);
const Color quaternaryColor = Color(0xffFFC93C);

const Color laravelColor = Color(0xfff55247);
const Color vueColor = Color(0xff42b883);
const Color bukuListrikColor = Color(0xff126F84);

final ThemeData kTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: primaryColor,
    primaryContainer: secondaryColor,
    secondary: tertiaryColor,
    secondaryContainer: quaternaryColor,
    surface: backgroundColor,
    background: backgroundColor,
    error: Colors.red,
    onPrimary: backgroundColor,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.black,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
  ),
  scaffoldBackgroundColor: backgroundColor,
);

// dark theme
const Color darkBackgroundColor = Color(0xff121212);

final ThemeData kDarkTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: primaryColor,
    primaryContainer: secondaryColor,
    secondary: tertiaryColor,
    secondaryContainer: quaternaryColor,
    surface: darkBackgroundColor,
    background: darkBackgroundColor,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  ),
  scaffoldBackgroundColor: darkBackgroundColor,
);

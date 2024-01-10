import 'package:flutter/material.dart';

final ThemeData synthwaveLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFFf772e0),

  splashColor: Color(0xFF30ecd0),

  iconTheme: const IconThemeData(
    color: Color(0xff30ecd0),
  ),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  colorScheme: const ColorScheme(
    primary: Color(0xFFf772e0),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 250, 158, 235),
    // Hungry bar color
    onSecondary: Color(0xFF30ecd0),
    // Money color
    tertiary: Color(0xFFffe4c8),
    // Hearts color
    error: Color(0xFFf9237b),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData synthwaveNightTheme = ThemeData(
  // Define your dark theme properties here
  primaryColor: Color(0xFFf772e0),

  iconTheme: const IconThemeData(
    color: Color(0xff30ecd0), // Set the icon color to blue
  ),

  splashColor: Color(0xFF30ecd0),

  disabledColor: const Color(0x61FFFFFF),

  colorScheme: const ColorScheme(
    primary: Color(0xFFf772e0),
    onPrimary: Color(0xFFf890e7),
    background: Color(0xFF1e1430),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 250, 158, 235),
    // Hungry bar color
    onSecondary: Color(0xFF30ecd0),
    // Money color
    tertiary: Color(0xFFffe4c8),
    // Hearts color
    error: Color(0xFFf9237b),
    onError: Colors.white,
    surface: Color.fromARGB(255, 34, 22, 56),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);
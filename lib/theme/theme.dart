import 'package:flutter/material.dart';

final ThemeData lightThemeData = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFFF772E1),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  splashColor: Color(0xFFF772E1),

  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 247, 114, 225),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0x00FA9EEB),
    onSecondary: Color(0xFFf6e58d),
    tertiary: Color(0xFFFECA57),
    onError: Colors.white,
    error: Color(0xFFff7675),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData darkThemeData = ThemeData(
  // Define your dark theme properties here
  primaryColor: const Color.fromARGB(255, 247, 114, 225),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231), // Set the icon color to blue
  ),

  splashColor: Color.fromARGB(255, 247, 114, 225),

  disabledColor: const Color(0x61FFFFFF),

  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 250, 158, 235),
    onPrimary: Color(0xDEFFFFFF),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 250, 158, 235),
    // Hungry bar color
    onSecondary: Color(0xFFff793f),
    // Money color
    tertiary: Color(0xFFFECA57),
    error: Color(0xFFff7675),
    onError: Colors.white,
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

final ThemeData pandaLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color.fromARGB(255, 8, 8, 8),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),
  splashColor: Color.fromARGB(255, 8, 8, 8),

  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 0, 0, 0),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0xFF202020),
    onSecondary: Color(0xFF909090),
    error: Color(0xFF909090),
    tertiary: Color.fromARGB(255, 0, 0, 0),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData pandaDarkTheme = ThemeData(
  // Define your dark theme properties here
  primaryColor: Color.fromARGB(255, 255, 255, 255),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231), // Set the icon color to blue
  ),

  splashColor: Color.fromARGB(255, 255, 255, 255),

  disabledColor: const Color(0x61FFFFFF),

  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 255, 255, 255),
    onPrimary: Color(0xFF181818),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 245, 242, 244),
    onSecondary: Color(0xFF909090),
    // Money color
    tertiary: Color.fromARGB(255, 255, 255, 255),
    error: Color(0xFF909090),
    onError: Color.fromARGB(255, 226, 221, 221),
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

final ThemeData iceLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFF4bcffa),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),

  splashColor: Color(0xFF4bcffa),
  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  colorScheme: const ColorScheme(
    primary: Color(0xFF4bcffa),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0x00FA9EEB),
    onSecondary: Color(0xFF4bcffa),
    error: Color(0xFF4bcffa),
    tertiary: Color(0xFF4bcffa),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData iceDarkTheme = ThemeData(
  primaryColor: Color(0xFF4bcffa),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231),
  ),

  splashColor: Color(0xFF4bcffa),
  disabledColor: const Color(0x61FFFFFF),
  colorScheme: const ColorScheme(
    primary: Color(0xFF4bcffa),
    onPrimary: Color(0xDEFFFFFF),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 245, 242, 244),
    // Money color
    tertiary: Color(0xFF4bcffa),
    onSecondary: Color(0xFF4bcffa),
    error: Color(0xFF4bcffa),
    onError: Colors.white,
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

final ThemeData rubyLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFFfe646f),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),
  splashColor: Color(0xFFfe646f),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  colorScheme: const ColorScheme(
    primary: Color(0xFFfe646f),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0x00FA9EEB),
    onSecondary: Color(0xFFfe646f),
    error: Color(0xFFfe646f),
    tertiary: Color(0xFFfe646f),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData rubyDarkTheme = ThemeData(
  primaryColor: Color(0xFFfe646f),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231),
  ),

  splashColor: Color(0xFFfe646f),
  disabledColor: const Color(0x61FFFFFF),
  colorScheme: const ColorScheme(
    primary: Color(0xFFfe646f),
    onPrimary: Color(0xDEFFFFFF),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 245, 242, 244),
    // Money color
    tertiary: Color(0xFFfe646f),
    onSecondary: Color(0xFFfe646f),
    error: Color(0xFFfe646f),
    onError: Colors.white,
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

final ThemeData lavenderLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFFFDA7DF),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),
  splashColor: Color(0xFFFDA7DF),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  colorScheme: const ColorScheme(
    primary: Color(0xFFFDA7DF),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0x00FA9EEB),
    onSecondary: Color(0xFFFDA7DF),
    error: Color(0xFFFDA7DF),
    tertiary: Color(0xFFFDA7DF),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData lavenderDarkTheme = ThemeData(
  primaryColor: Color(0xFFFDA7DF),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231),
  ),
  splashColor: Color(0xFFFDA7DF),
  disabledColor: const Color(0x61FFFFFF),
  colorScheme: const ColorScheme(
    primary: Color(0xFFFDA7DF),
    onPrimary: Color(0xDEFFFFFF),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 245, 242, 244),
    // Money color
    tertiary: Color(0xFFFDA7DF),
    onSecondary: Color(0xFFFDA7DF),
    error: Color(0xFFFDA7DF),
    onError: Colors.white,
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

final ThemeData mentaLightTheme = ThemeData(
  // Define your light theme properties here
  primaryColor: Color(0xFF7bed9f),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 3, 3, 3),
  ),

  splashColor: Color(0xFF7bed9f),

  buttonTheme: const ButtonThemeData(
    // Customize the icon color within IconButton
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 92, 99, 112),
    ),
  ),

  colorScheme: const ColorScheme(
    primary: Color(0xFF7bed9f),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 3, 3, 3),
    secondary: Color(0x00FA9EEB),
    onSecondary: Color(0xFF7bed9f),
    error: Color(0xFF7bed9f),
    tertiary: Color(0xFF7bed9f),
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
);

final ThemeData mentaDarkTheme = ThemeData(
  primaryColor: Color(0xFF7bed9f),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 231, 231, 231),
  ),
  splashColor: Color(0xFF7bed9f),
  disabledColor: const Color(0x61FFFFFF),
  colorScheme: const ColorScheme(
    primary: Color(0xFF7bed9f),
    onPrimary: Color(0xDEFFFFFF),
    background: Color(0xFF181818),
    onBackground: Color(0xDEFFFFFF),
    secondary: Color.fromARGB(255, 245, 242, 244),
    // Money color
    tertiary: Color(0xFF7bed9f),
    onSecondary: Color(0xFF7bed9f),
    error: Color(0xFF7bed9f),
    onError: Colors.white,
    surface: Color(0xFF202020),
    onSurface: Colors.black,
    brightness: Brightness.dark,
  ),
);

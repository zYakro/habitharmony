import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class ThemeModeIcon extends StatefulWidget {
  const ThemeModeIcon({super.key});

  @override
  State<ThemeModeIcon> createState() => _ThemeModeIconState();
}

class _ThemeModeIconState extends State<ThemeModeIcon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
        duration: const Duration(milliseconds: 100),
        onPressed: () {
          AdaptiveTheme.of(context).toggleThemeMode();
        },
        child: Icon(
          Icons.toggle_off_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ));
  }
}

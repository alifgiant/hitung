import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';

import 'src/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const whiteText = const TextStyle(color: HitungColor.white);
    return MaterialApp(
      title: 'Hitung',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff9A4532), // kula color
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: HitungColor.snow,
          selectionColor: HitungColor.white.withAlpha(60),
        ),
        textTheme: TextTheme(
          bodySmall: whiteText,
          bodyMedium: whiteText,
          bodyLarge: whiteText,
          labelSmall: whiteText,
          labelMedium: whiteText,
          labelLarge: whiteText,
          displaySmall: whiteText,
          displayMedium: whiteText,
          displayLarge: whiteText,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
        ),
        scaffoldBackgroundColor: HitungColor.black,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

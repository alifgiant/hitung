import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';

import 'src/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const whiteText = TextStyle(color: HitungColor.white);
    const snowText = TextStyle(color: Color(0xff3c3c3c));
    return MaterialApp(
      title: 'Hitung',
      theme: ThemeData(
        scaffoldBackgroundColor: HitungColor.black,
        appBarTheme: AppBarTheme(
          backgroundColor: HitungColor.black,
          toolbarTextStyle: snowText,
          titleTextStyle: snowText,
        ),
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
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

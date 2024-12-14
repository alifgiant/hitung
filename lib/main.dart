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
    return MaterialApp(
      title: 'Hitung',
      theme: ThemeData.dark().copyWith(
        // scaffoldBackgroundColor: HitungColor.black,
        appBarTheme: AppBarTheme(
          backgroundColor: HitungColor.black,
          titleTextStyle: TextStyle(color: HitungColor.white),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: HitungColor.burntAmber, // kula color
          // surface: HitungColor.black,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: HitungColor.snow,
          selectionColor: HitungColor.white.withAlpha(60),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
        ),
      ),
      home: const MainPage(),
    );
  }
}

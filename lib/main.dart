import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';
import 'package:hitung/src/core/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/main_page.dart';

void main() async {
  // create storage
  final sharedPreferences = await SharedPreferences.getInstance();
  Storage.i = Storage(sharedPreferences: sharedPreferences);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: HitungColor.black,
        appBarTheme: AppBarTheme(
          backgroundColor: HitungColor.black,
          titleTextStyle: TextStyle(color: HitungColor.white),
          iconTheme: IconThemeData(color: HitungColor.white, size: 14),
          actionsIconTheme: IconThemeData(color: HitungColor.white, size: 14),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: HitungColor.burntAmber, // kula color
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

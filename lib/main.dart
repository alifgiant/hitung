import 'package:flutter/material.dart';

import 'src/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff9A4532), // kula color
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

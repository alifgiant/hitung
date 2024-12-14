import 'package:flutter/material.dart';
import 'package:hitung/src/screens/note_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: NoteScreen(noteName: 'main-note'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hitung/src/screens/note_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 32,
        title: Text('Main Page'),
        leading: IconButton.filledTonal(
          iconSize: 12,
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),
      body: NoteScreen(noteName: 'main-note'),
    );
  }
}

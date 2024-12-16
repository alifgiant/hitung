import 'package:flutter/material.dart';
import 'package:hitung/src/core/note_provider.dart';
import 'package:hitung/src/screens/drawer.dart';
import 'package:hitung/src/screens/note_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NoteProvider noteProvider = NoteProvider();

  @override
  void initState() {
    super.initState();
    noteProvider.initState();
  }

  @override
  void dispose() {
    noteProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: noteProvider,
      builder: (context, child) {
        return Scaffold(
          endDrawer: NoteDrawer(noteProvider: noteProvider),
          appBar: AppBar(
            toolbarHeight: 32,
            title: Text(noteProvider.selectedNote),
          ),
          body: NoteScreen(noteName: noteProvider.selectedNote),
        );
      },
    );
  }
}

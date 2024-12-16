import 'package:flutter/material.dart';
import 'package:hitung/src/core/note_provider.dart';
import 'package:hitung/src/screens/drawer.dart';
import 'package:hitung/src/screens/note_screen.dart';
import 'package:hitung/src/utils/utils.dart';

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
      builder: (ctx, child) {
        return Scaffold(
          endDrawer: NoteDrawer(noteProvider: noteProvider),
          body: Column(
            children: [
              NoteScreen(noteName: noteProvider.selectedNote).expanded(),
              AppBar(
                toolbarHeight: 32,
                title: Text(noteProvider.selectedNote),
              ),
              SizedBox(height: ctx.bottomPadding),
            ],
          ),
        );
      },
    );
  }
}

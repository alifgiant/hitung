import 'package:flutter/material.dart';
import 'package:hitung/src/screens/note_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Note'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Builder(builder: (ctx) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Hitung',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Pengaturan',
            ),
          ],
          onTap: (pos) {
            switch (pos) {
              case 0:
                break;
              case 1:
                Scaffold.of(ctx).openEndDrawer();
                break;
            }
          },
        );
      }),
      appBar: AppBar(
        toolbarHeight: 32,
        title: Text('Main Note'),
        centerTitle: false,
        actions: [SizedBox()],
      ),
      body: NoteScreen(noteName: 'Main Note'),
    );
  }
}

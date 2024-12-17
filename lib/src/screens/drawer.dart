import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';
import 'package:hitung/src/core/note_provider.dart';
import 'package:hitung/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteDrawer extends StatelessWidget {
  final NoteProvider noteProvider;

  const NoteDrawer({
    super.key,
    required this.noteProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(title: Text('Daftar Catatan')),
          ListView.builder(
            itemCount: noteProvider.noteNames.length,
            itemBuilder: (context, index) => ListTile(
              dense: true,
              title: Text(
                noteProvider.noteNames[index],
                style: TextStyle(
                  color:
                      noteProvider.noteNames[index] == noteProvider.selectedNote
                          ? Theme.of(context).colorScheme.primary
                          : null,
                ),
              ),
              onTap: () {
                noteProvider.selectNote(noteProvider.noteNames[index]);
                Navigator.pop(context);
              },
              trailing: noteProvider.noteNames.length > 1
                  ? IconButton.filledTonal(
                      visualDensity: VisualDensity(
                        vertical: VisualDensity.minimumDensity,
                        horizontal: VisualDensity.minimumDensity,
                      ),
                      iconSize: 16,
                      color: HitungColor.burntAmber,
                      onPressed: () {
                        noteProvider.deleteNote(noteProvider.noteNames[index]);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.delete_forever_rounded),
                    )
                  : null,
            ),
          ).expanded(),
          const Divider(),
          ListTile(
            title: Text('Tambah Catatan'),
            trailing: IconButton.filledTonal(
              icon: Icon(Icons.add_rounded),
              onPressed: () => showCreateNoteDialog(context),
            ),
          ),
          ListTile(
            title: Text('Baca Petunjuk'),
            trailing: IconButton.filledTonal(
              icon: Icon(Icons.search_rounded),
              onPressed: () => launchUrl(
                Uri.parse(
                  'https://alifgiant.notion.site/Hitung-15c835c2e62f8063b088ffea5e88b4b6',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Future<void> showCreateNoteDialog(BuildContext context) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final title = await showDialog<String>(
      context: context,
      builder: (ctx) {
        String name = '';
        return AlertDialog(
          title: Text(
            'Tambah Catatan',
            style: TextStyle(color: HitungColor.black),
          ),
          content: TextField(
            style: TextStyle(color: HitungColor.black),
            cursorColor: HitungColor.black,
            decoration: InputDecoration(
              labelText: 'Nama catatan',
              hintText: 'Catatan 2',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
            onChanged: (value) => name = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, name),
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (title == null) return;
    if (noteProvider.noteNames.contains(title)) {
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Catatan sudah ada, silahkan buat catatan lain',
          ),
        ),
      );
    } else {
      noteProvider.createNote(title);
      navigator.pop();
    }
  }
}

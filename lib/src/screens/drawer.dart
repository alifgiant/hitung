import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';
import 'package:hitung/src/core/note_provider.dart';
import 'package:hitung/src/utils/utils.dart';

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
              title: Row(
                children: [
                  Text(
                    noteProvider.noteNames[index],
                    style: TextStyle(
                      color: noteProvider.noteNames[index] ==
                              noteProvider.selectedNote
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  const SizedBox(width: 2),
                  IconButton(
                    visualDensity: VisualDensity(
                      vertical: VisualDensity.minimumDensity,
                      horizontal: VisualDensity.minimumDensity,
                    ),
                    iconSize: 12,
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
              onTap: () {
                noteProvider.selectNote(noteProvider.noteNames[index]);
                Navigator.pop(context);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filledTonal(
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
                  ),
                ],
              ),
            ),
          ).expanded(),
          const Divider(),
          ListTile(
            title: Text('Tambah Catatan'),
            trailing: IconButton.filledTonal(
              icon: Icon(Icons.add_rounded),
              onPressed: () async {
                final title = await showDialog<String>(
                  context: context,
                  builder: (context) {
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
                          onPressed: () => Navigator.pop(context),
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, name),
                          child: Text('Simpan'),
                        ),
                      ],
                    );
                  },
                );
                if (title == null) return;
                noteProvider.createNote(title);
              },
            ),
          ),
          ListTile(
            title: Text('Baca Petunjuk'),
            trailing: IconButton.filledTonal(
              icon: Icon(Icons.search_rounded),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

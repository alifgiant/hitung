import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';
import 'package:hitung/src/core/note_text_controller.dart';
import 'package:hitung/src/core/storage.dart';
import 'package:hitung/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteScreen extends StatefulWidget {
  final String noteName;

  const NoteScreen({
    super.key,
    required this.noteName,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late final Storage storage;
  final NoteTextController noteTextController = NoteTextController();

  @override
  void initState() {
    super.initState();
    noteTextController.addListener(saveNote);
    Future.microtask(() async {
      storage = Storage(
        sharedPreferences: await SharedPreferences.getInstance(),
      );
      loadSavedNote(widget.noteName);
    });
  }

  @override
  void didUpdateWidget(NoteScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.noteName == widget.noteName) return;
    loadSavedNote(widget.noteName);
  }

  @override
  void dispose() {
    noteTextController.dispose();
    super.dispose();
  }

  void loadSavedNote(String noteName) {
    noteTextController.text = storage.getNoteContent(noteName);
  }

  void saveNote() {
    storage.saveNoteContent(widget.noteName, noteTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.noteName.isNotEmpty)
            TextField(
              maxLines: null,
              expands: true,
              controller: noteTextController,
            ).expanded()
          else
            Center(child: Text('Silahkan buat catatan')).expanded(),
          AnimatedBuilder(
            animation: noteTextController.calcContextProvider,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 1,
                children: noteTextController.calcContextProvider.calcContexts
                    .map(
                      (e) => Text(
                        e.output,
                        style: TextStyle(
                          fontSize: 16,
                          color: HitungColor.mantis,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ).dynamicFixedWidth(context, width: 200),
        ],
      ),
    );
  }
}

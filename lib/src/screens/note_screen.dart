import 'package:flutter/material.dart';
import 'package:hitung/src/core/note_text_controller.dart';
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
  late final SharedPreferences sharedPreferences;
  final NoteTextController noteTextController = NoteTextController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      sharedPreferences = await SharedPreferences.getInstance();
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
    noteTextController.text = sharedPreferences.getString(noteName) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: null,
            expands: true,
          ).expanded(),
          Column().dynamicFixedWidth(
            context,
            width: 200,
          ),
        ],
      ),
    );
  }
}
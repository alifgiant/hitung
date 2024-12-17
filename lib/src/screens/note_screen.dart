import 'package:flutter/material.dart';
import 'package:hitung/src/core/calc_context.dart';
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
  final Key _key = GlobalKey();
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
    final isInitialLoad = storage.isInitialLoad();
    final savedContent = storage.getNoteContent(noteName);
    final defaultContent = [
      '// menghitung luas segitiga',
      'alas = 4',
      'tinggi = 10',
      'luas = 1/2 * alas * tinggi',
      '',
      '// penjumlahan',
      '20m',
      '-100k',
      'sum',
    ].join('\n');
    noteTextController.text = isInitialLoad ? defaultContent : savedContent;
  }

  void saveNote() {
    storage.saveNoteContent(widget.noteName, noteTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    const padding = 12.0;
    final screenWidth = context.width - (padding * 2);
    final targetResultWidth = 500.0;
    final resultWidth = screenWidth >= targetResultWidth * 3
        ? targetResultWidth
        : screenWidth * 0.3;
    final expWidth = screenWidth - resultWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.noteName.isNotEmpty)
          TextField(
            key: _key,
            maxLines: null,
            expands: true,
            controller: noteTextController,
            style: _style,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true
            ),
          ).expanded()
        else
          Center(
            child: Text('Silahkan buat catatan'),
          ).expanded(),
        AnimatedBuilder(
          animation: noteTextController.calcContextProvider,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...noteTextController.calcContextProvider.calcContexts
                    .map((e) => _buildResult(e, expWidth)),
              ],
            );
          },
        ).fixedWidth(width: resultWidth),
      ],
    ).allPadding(padding);
  }

  Widget _buildResult(CalcContext calcContext, double expWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: calcContext.input, style: _style),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    textPainter.layout(maxWidth: expWidth - 36);

    // Get line height
    double lineHeight = textPainter.height;

    return SizedBox(
      height: lineHeight,
      child: Text(
        calcContext.output,
        style: _style.copyWith(color: HitungColor.mantis),
      ),
    );
  }
}

// Match TextField style
const _style = TextStyle(fontSize: 16, height: 1.6);

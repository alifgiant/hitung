import 'package:flutter/material.dart';

import 'calc_context_provider.dart';

class NoteTextController extends TextEditingController {
  final CalcContextProvider calcContextProvider;

  NoteTextController({
    CalcContextProvider? calcContextProvider,
  }) : calcContextProvider = calcContextProvider ?? CalcContextProvider() {
    addListener(() {
      this.calcContextProvider.onLineChanged(text);
    });
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      children: _buildTextSpans(text, style),
      style: style,
    );
  }

  List<TextSpan> _buildTextSpans(String text, TextStyle? style) {
    final lines = text.split('\n');
    return [
      for (int i = 0; i < lines.length; i++) _buildLine(i, lines[i], style),
    ];
  }

  TextSpan _buildLine(int lineIndex, String text, TextStyle? style) {
    return TextSpan(
      children: [
        TextSpan(text: text),
        TextSpan(text: '\n'),
      ],
      style: style,
    );
  }

  @override
  void dispose() {
    calcContextProvider.dispose();
    super.dispose();
  }
}

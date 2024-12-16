import 'package:flutter/material.dart';
import 'package:hitung/src/core/token.dart';

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
      for (int i = 0; i < lines.length; i++) _buildLine(i, lines, style),
    ];
  }

  TextSpan _buildLine(int lineIndex, List<String> lines, TextStyle? style) {
    final text = lines[lineIndex];
    List<InlineSpan> children = [];
    if (calcContextProvider.calcContexts.isEmpty) {
      children.add(TextSpan(text: text, style: style));
    } else {
      final context = calcContextProvider.calcContexts[lineIndex];
      final tokens = context.tokens.toList();
      // tokens.removeLast();
      tokens.removeWhere(
        (element) {
          final isExpression = element.type == TokenType.expression;
          // dont need render unfound variable
          final notFoundVar = !text.contains(element.text);
          return isExpression || notFoundVar;
        },
      );
      tokens.sort((a, b) => a.start.compareTo(b.start));

      if (text.isEmpty || tokens.isEmpty) {
        children.add(TextSpan(text: text, style: style));
      } else {
        int start = 0;
        for (int i = 0; i < tokens.length; i++) {
          final token = tokens[i];

          final startToken = token.start;
          final endToken = token.start + token.text.length;
          children.add(
            TextSpan(text: text.substring(start, startToken), style: style),
          );
          children.add(
            TextSpan(
              text: text.substring(startToken, endToken),
              style: style?.copyWith(color: token.type.color),
            ),
          );
          final end = i + 1 < tokens.length ? tokens[i + 1].start : text.length;
          children.add(
            TextSpan(text: text.substring(endToken, end), style: style),
          );
          start = end;
        }
      }
    }
    return TextSpan(
      children: [
        ...children,
        if (lineIndex < lines.length) TextSpan(text: '\n'),
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

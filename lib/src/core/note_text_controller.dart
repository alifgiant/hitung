import 'package:flutter/material.dart';

import 'calc_context_provider.dart';

class NoteTextController extends TextEditingController {
  final CalcContextProvider calcContextProvider;

  NoteTextController({
    CalcContextProvider? calcContextProvider,
  }) : calcContextProvider = calcContextProvider ?? CalcContextProvider() {
    addListener(() => this.calcContextProvider.onLineChanged(text));
  }
  
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // TODO: implement buildTextSpan
    return super.buildTextSpan(
      context: context,
      style: style,
      withComposing: withComposing,
    );
  }

  @override
  void dispose() {
    calcContextProvider.dispose();
    super.dispose();
  }
}

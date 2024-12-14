import 'package:flutter/material.dart';
import 'package:hitung/src/core/calc_context.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcContextProvider with ChangeNotifier {
  final Parser parser;
  final List<CalcContext> calcContexts;

  CalcContextProvider({
    Parser? parser,
    List<CalcContext>? calcContexts,
  })  : parser = parser ?? Parser(ParserOptions(implicitMultiplication: true)),
        calcContexts = calcContexts ?? List.empty(growable: true);

  void onLineChanged(String text) {
    final lines = text.split('\n');

    // flag to inform subsequent line if there are changes in line before
    // so expression need to be updated
    bool hasChanges = false;

    for (int pos = 0; pos < lines.length; pos++) {
      final line = lines[pos];

      // if context for the position is exist
      final bool hasContext = pos < calcContexts.length;
      if (hasContext) {
        final existingContext = calcContexts[pos];
        if (line == existingContext.input && !hasChanges) continue;

        // if input is different, then there are changes
        hasChanges = true;
      }

      // if context for the position is not exist
      // or input is different
      // or there are changes in previous line
      // then current line needs reevaluation

      // get previous line contexts or use empty context
      final prevPos = pos - 1;
      final prevContext = prevPos >= 0 && prevPos < calcContexts.length
          ? calcContexts[prevPos]
          : CalcContext.empty;

      // try to create a new context, based on previous line contexts
      final newContext = ContextModel();
      newContext.variables = {
        ...prevContext.contextModel.variables,
      };

      // evaluate line and get result
      final result = newContext.bindLineResult(parser, line);
      final calcContext = CalcContext(newContext, '$line\n', output: result);

      // if existing context exists, remove it
      if (hasContext) calcContexts.removeAt(pos);

      // insert new context
      calcContexts.insert(pos, calcContext);

      notifyListeners();
    }
  }
}

class NoteTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    // TODO: implement buildTextSpan
    return super.buildTextSpan(
        context: context, style: style, withComposing: withComposing);
  }
}

extension ContextBinder on ContextModel {
  /// process expression, bind new var if any
  /// and return string result of the expression
  String bindLineResult(Parser parser, String line) {
    final splitVar = line.split('=');
    String resultStr = '';
    try {
      if (splitVar.length == 1) {
        // no new variable definition
        final result = parser.parse(line).evaluate(EvaluationType.REAL, this);
        resultStr = result.toString();
      } else if (splitVar.length == 2) {
        // has new variable definition
        final varName = splitVar[0].trim();
        final rawExp = splitVar[1].trim();
        final result = parser.parse(rawExp).evaluate(EvaluationType.REAL, this);
        bindVariableName(varName, Number(result));
        resultStr = result.toString();
      } else {
        // broken line
      }
    } catch (e) {
      // broken line
    }

    print('resultStr: $resultStr');
    return resultStr;
  }
}

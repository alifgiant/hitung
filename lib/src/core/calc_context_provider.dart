import 'package:flutter/material.dart';
import 'package:hitung/src/core/token.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart' hide Token, TokenType;

import 'calc_context.dart';

class CalcContextProvider with ChangeNotifier {
  final Parser _parser;
  final List<CalcContext> calcContexts;
  final NumberFormat _numberFormat;

  CalcContextProvider({
    Parser? parser,
    List<CalcContext>? calcContexts,
    NumberFormat? numberFormat,
  })  : _parser = parser ?? Parser(ParserOptions(implicitMultiplication: true)),
        calcContexts = calcContexts ?? List.empty(growable: true),
        _numberFormat = numberFormat ?? NumberFormat.decimalPattern()
          ..maximumFractionDigits = 5;

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
      final hitungTokens = _tokenize(line, pos, newContext);
      final expToken = hitungTokens.last;
      final result = newContext.evaluate(
        _parser,
        _numberFormat,
        expToken.text,
      );
      if (hitungTokens.first.type == TokenType.assignment) {
        final resultNum = _numberFormat.tryParse(result) ?? 0;
        newContext.bindVariableName(hitungTokens.first.text, Number(resultNum));
      }
      final calcContext = CalcContext(
        newContext,
        line,
        output: result,
        tokens: hitungTokens,
      );

      // if existing context exists, remove it
      if (hasContext) calcContexts.removeAt(pos);

      // insert new context
      calcContexts.insert(pos, calcContext);
    }

    // remove extra context
    if (calcContexts.length > lines.length) {
      calcContexts.removeRange(lines.length, calcContexts.length);
    }

    notifyListeners();
  }

  List<Token> _tokenize(String line, int pos, ContextModel context) {
    // check wether line is empty
    if (line.trim().isEmpty) {
      return [Token(text: '', type: TokenType.expression, start: -1)];
    }

    String processedLine = line;

    // check wether line has assignment at starts
    final match = TokenType.assignment.regex.matchAsPrefix(line);
    final startIndex = match != null ? match.end : 0;
    Token? assignmentToken;
    if (match != null) {
      final varName = match.group(1)!;
      if (!varName.contains(' ')) {
        assignmentToken = Token(
          text: varName,
          type: TokenType.assignment,
          start: match.start,
        );
      }
      processedLine = processedLine.substring(match.end);
    }

    // check wether line has comments at ends
    final commentIndex = processedLine.indexOf(TokenType.comments.regex);
    Token? commentToken;
    if (commentIndex > -1) {
      final comment = processedLine.substring(commentIndex);
      processedLine = processedLine.substring(0, commentIndex);
      commentToken = Token(
        text: comment,
        type: TokenType.comments,
        start: commentIndex + startIndex,
      );
    }

    // check wether line has short numbers
    final shortNumTokens =
        TokenType.shortNum.regex.allMatches(processedLine).map(
      (shortNum) {
        final text = shortNum.group(0)!;

        return Token(
          text: text,
          type: TokenType.shortNum,
          start: shortNum.start + startIndex,
        );
      },
    );

    for (var shorNumToken in shortNumTokens) {
      final multiplier =
          switch (shorNumToken.text.characters.last.toLowerCase()) {
        'k' => 1000,
        'm' => 1000000,
        'b' => 1000000000,
        _ => 1,
      };
      final value = num.tryParse(
        shorNumToken.text.substring(0, shorNumToken.text.length - 1),
      );
      final fullValue = (value ?? 0) * multiplier;
      processedLine = processedLine.replaceAll(
        shorNumToken.text,
        fullValue.toString(),
      );
    }

    // check wether line has variables
    final variableTokens = context.variables.keys.map(
      (variable) {
        final varIndex = processedLine.indexOf(variable);
        return Token(
          text: variable,
          type: TokenType.variable,
          start: varIndex + startIndex,
        );
      },
    );

    // check wether line is a sum function
    Token? sumToken;
    if (processedLine.toLowerCase().trim() == 'sum') {
      final sumText = processedLine.trim();
      sumToken = Token(
        text: sumText,
        type: TokenType.sum,
        start: processedLine.indexOf(sumText) + startIndex,
      );

      int prevPos = pos - 1;
      List<num> prevResult = [];
      while (prevPos >= 0 &&
          prevPos < calcContexts.length &&
          calcContexts[prevPos].output.isNotEmpty) {
        final resultNum = _numberFormat.tryParse(calcContexts[prevPos].output);
        prevResult.add(resultNum ?? 0);
        prevPos--;
      }

      processedLine = prevResult.join('+'); // create sum expression
    }

    return [
      if (assignmentToken != null) assignmentToken,
      ...shortNumTokens,
      ...variableTokens,
      if (commentToken != null) commentToken,
      if (sumToken != null) sumToken,
      Token(text: processedLine, type: TokenType.expression, start: -1),
    ];
  }
}

extension ContextBinder on ContextModel {
  /// evaluate expression
  /// and return string result of the expression
  String evaluate(Parser parser, NumberFormat numberFormat, String expression) {
    try {
      // no new variable definition
      final parsed = parser.parse(expression);
      final result = parsed.evaluate(EvaluationType.REAL, this);
      return numberFormat.format(result);
    } catch (e) {
      return '';
    }
  }
}

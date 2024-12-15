import 'package:hitung/src/core/token.dart';
import 'package:math_expressions/math_expressions.dart' hide Token;

class CalcContext {
  final ContextModel contextModel;
  final List<Token> tokens;
  final String input;
  final String output;

  const CalcContext(
    this.contextModel,
    this.input, {
    this.output = '',
    this.tokens = const [],
  });

  static final empty = CalcContext(ContextModel(), '', output: '');
}

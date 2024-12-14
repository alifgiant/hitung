import 'package:math_expressions/math_expressions.dart';

class CalcContext {
  final ContextModel contextModel;
  final String input;
  final String output;

  const CalcContext(
    this.contextModel,
    this.input, {
    this.output = '',
  });

  static final empty = CalcContext(ContextModel(), '', output: '');
}

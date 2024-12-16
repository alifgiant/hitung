import 'package:flutter/material.dart';
import 'package:hitung/src/core/colors.dart';

class TokenType {
  final RegExp regex;
  final Color? color;
  const TokenType._(this.regex, {this.color});

  static final comments = TokenType._(
    RegExp(r'\s*//.*'),
    color: HitungColor.snow,
  );
  static final assignment = TokenType._(
    RegExp(r'(.*[^\s])\s*=\s*'),
    color: HitungColor.teal,
  );
  static final shortNum = TokenType._(
    RegExp(r'([0-9]+(\.[0-9]*)?)[kmb]', caseSensitive: false),
  );
  static final variable = TokenType._(
    RegExp(r''),
    color: HitungColor.teal,
  );
  static final expression = TokenType._(RegExp(r''));
}

class Token {
  final String text;
  final TokenType type;
  final int start;

  const Token({
    required this.text,
    required this.type,
    required this.start,
  });
}

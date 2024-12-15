class TokenType {
  final RegExp regex;
  const TokenType._(this.regex);

  static final comments = TokenType._(
    RegExp(r'\s*//.*'),
  );
  static final assignment = TokenType._(
    RegExp(r'(.*[^\s])\s*=\s*'),
  );
  static final shortNum = TokenType._(
    RegExp(r'([0-9]+(\.[0-9]*)?)[kmb]', caseSensitive: false),
  );
  static final variable = TokenType._(RegExp(r''));
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

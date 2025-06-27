
final _upperAlphaRegex = RegExp(r'[A-Z]');

const _symbolSet = {' ', '.', '/', '_', '\\', '-'};

/// Extension on [String]
extension StringReCase on String {

  /// Converts the string to PascalCase.
  String get pascalCase => getPascalCase();

  /// Converts the string to PascalCase.
  String getPascalCase({String separator = ''}) {
    final words = _groupIntoWords(this);
    return words.map(_upperCaseFirstLetter).join(separator);
  }

  List<String> _groupIntoWords(String text) {
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = text.toUpperCase() == text;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final nextChar = i + 1 == text.length ? null : text[i + 1];

      if (_symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      final isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }

}
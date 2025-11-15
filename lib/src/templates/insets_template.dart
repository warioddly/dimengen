import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/recase.dart';

/// Template for generating inset configurations.
class InsetsTemplate extends Template {
  @override
  String generateFor(Map<String, String> fields) {
    final buffer = StringBuffer();

    for (final MapEntry(:key, :value) in fields.entries) {
      _generateSingleInsets(buffer, key, value);
      _generateCombinedInsets(buffer, key, value, fields);
    }

    return buffer.toString();
  }

  /// Generates single-value inset configurations.
  void _generateSingleInsets(StringBuffer buffer, String name, String val) {
    buffer
      ..writeln('static const EdgeInsets $name = .all($val);')
      ..writeln('static const EdgeInsets ${name}Top = .only(top: $val);')
      ..writeln('static const EdgeInsets ${name}Bottom = .only(bottom: $val);')
      ..writeln('static const EdgeInsets ${name}Left = .only(left: $val);')
      ..writeln('static const EdgeInsets ${name}Right = .only(right: $val);')
      ..writeln('static const EdgeInsets ${name}Vertical = .symmetric(vertical: $val);')
      ..writeln('static const EdgeInsets ${name}Horizontal = .symmetric(horizontal: $val);');
  }

  /// Generates combined inset configurations using two different values.
  void _generateCombinedInsets(StringBuffer buffer, String name, String val, Map<String, String> fields) {
    for (final MapEntry(:key, :value) in fields.entries) {
      if (name == key) continue;

      final pascalName = key.pascalCase;

      buffer
        ..writeln('static const EdgeInsets ${name}Top${pascalName}Bottom = .only(top: $val, bottom: $value);')
        ..writeln('static const EdgeInsets ${name}Left${pascalName}Right = .only(left: $val, right: $value);')
        ..writeln('static const EdgeInsets ${name}Top${pascalName}Left = .only(top: $val, left: $value);')
        ..writeln('static const EdgeInsets ${name}Right${pascalName}Bottom = .only(right: $val, bottom: $value);');
    }
  }
}

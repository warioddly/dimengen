import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/recase.dart';

/// Template for generating inset configurations.
class InsetsTemplate extends Template {
  @override
  String generateFor(Map<String, String> fields) {
    final buffer = StringBuffer();

    for (final entry in fields.entries) {
      final name = entry.key;
      final val = entry.value;

      buffer
        ..writeln('static const EdgeInsets $name = EdgeInsets.all($val);')
        ..writeln('static const EdgeInsets ${name}Top = EdgeInsets.only(top: $val);')
        ..writeln('static const EdgeInsets ${name}Bottom = EdgeInsets.only(bottom: $val);')
        ..writeln('static const EdgeInsets ${name}Left = EdgeInsets.only(left: $val);')
        ..writeln('static const EdgeInsets ${name}Right = EdgeInsets.only(right: $val);')
        ..writeln('static const EdgeInsets ${name}Vertical = EdgeInsets.symmetric(vertical: $val);')
        ..writeln('static const EdgeInsets ${name}Horizontal = EdgeInsets.symmetric(horizontal: $val);');

      for (final e2 in fields.entries) {
        final k2 = e2.key, v2 = e2.value;

        if (name == k2) continue;

        final pascaleName = k2.pascalCase;

        buffer
          ..writeln('static const EdgeInsets ${name}Top${pascaleName}Bottom = EdgeInsets.only(top: $val, bottom: $v2);')
          ..writeln('static const EdgeInsets ${name}Left${pascaleName}Right = EdgeInsets.only(left: $val, right: $v2);')
          ..writeln('static const EdgeInsets ${name}Top${pascaleName}Left = EdgeInsets.only(top: $val, left: $v2);')
          ..writeln('static const EdgeInsets ${name}Right${pascaleName}Bottom = EdgeInsets.only(right: $val, bottom: $v2);');

      }
    }

    return buffer.toString();
  }
}

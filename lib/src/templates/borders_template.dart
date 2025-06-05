import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/recase.dart';

/// Template for generating border radius configurations.
class BordersTemplate extends Template {
  @override
  String generateFor(Map<String, String> values) {
    final buffer = StringBuffer();

    for (final entry in values.entries) {
      final name = entry.key;
      final val = 'Radius.circular(${entry.value})';

      buffer
        ..writeln('static const BorderRadius $name = BorderRadius.all($val);')
        ..writeln('static const BorderRadius ${name}Top = BorderRadius.only(topLeft: $val, topRight: $val);')
        ..writeln('static const BorderRadius ${name}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $val);')
        ..writeln('static const BorderRadius ${name}Left = BorderRadius.only(topLeft: $val, bottomLeft: $val);')
        ..writeln('static const BorderRadius ${name}Right = BorderRadius.only(topRight: $val, bottomRight: $val);')
        ..writeln('static const BorderRadius ${name}Vertical = BorderRadius.vertical(top: $val, bottom: $val);')
        ..writeln('static const BorderRadius ${name}Horizontal = BorderRadius.horizontal(left: $val, right: $val);')
        ..writeln('static const BorderRadius ${name}TopLeft = BorderRadius.only(topLeft: $val);')
        ..writeln('static const BorderRadius ${name}TopRight = BorderRadius.only(topRight: $val);')
        ..writeln('static const BorderRadius ${name}BottomLeft = BorderRadius.only(bottomLeft: $val);')
        ..writeln('static const BorderRadius ${name}BottomRight = BorderRadius.only(bottomRight: $val);')
        ..writeln('static const BorderRadius ${name}TopLeftBottomRight = BorderRadius.only(topLeft: $val, bottomRight: $val);')
        ..writeln('static const BorderRadius ${name}TopRightBottomLeft = BorderRadius.only(topRight: $val, bottomLeft: $val);');

      for (final e2 in values.entries) {
        final k1 = name;
        final k2 = e2.key, v2 = 'Radius.circular(${e2.value})';

        if (k1 == k2) continue;

        final k2PascalCased = k2.pascalCase;

        buffer
          ..writeln('static const BorderRadius ${k1}Top${k2PascalCased}Left = BorderRadius.only(topLeft: $val, topRight: $v2);')
          ..writeln('static const BorderRadius ${k1}Right${k2PascalCased}Bottom = BorderRadius.only(topRight: $val, bottomLeft: $v2);')
          ..writeln('static const BorderRadius ${k1}Top${k2PascalCased}Right = BorderRadius.only(topLeft: $val, bottomRight: $v2);')
          ..writeln('static const BorderRadius ${k1}Bottom${k2PascalCased}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $v2);');

      }
    }

    return buffer.toString();
  }
}

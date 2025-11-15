import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/recase.dart';

/// Template for generating border radius configurations.
class BordersTemplate extends Template {
  @override
  String generateFor(Map<String, String> fields) {
    final buffer = StringBuffer();

    for (final MapEntry(:key, :value) in fields.entries) {
      final radiusValue = _formatRadius(value);
      _generateSingleBorders(buffer, key, radiusValue);
      _generateCombinedBorders(buffer, key, radiusValue, fields);
    }

    return buffer.toString();
  }

  /// Formats the radius value as Radius.circular(...).
  String _formatRadius(String value) => 'Radius.circular($value)';

  /// Generates single-value border radius configurations.
  void _generateSingleBorders(StringBuffer buffer, String name, String val) {
    buffer
      ..writeln('static const BorderRadius $name = .all($val);')
      ..writeln('static const BorderRadius ${name}Top = .only(topLeft: $val, topRight: $val);')
      ..writeln('static const BorderRadius ${name}Bottom = .only(bottomLeft: $val, bottomRight: $val);')
      ..writeln('static const BorderRadius ${name}Left = .only(topLeft: $val, bottomLeft: $val);')
      ..writeln('static const BorderRadius ${name}Right = .only(topRight: $val, bottomRight: $val);')
      ..writeln('static const BorderRadius ${name}Vertical = .vertical(top: $val, bottom: $val);')
      ..writeln('static const BorderRadius ${name}Horizontal = .horizontal(left: $val, right: $val);')
      ..writeln('static const BorderRadius ${name}TopLeft = .only(topLeft: $val);')
      ..writeln('static const BorderRadius ${name}TopRight = .only(topRight: $val);')
      ..writeln('static const BorderRadius ${name}BottomLeft = .only(bottomLeft: $val);')
      ..writeln('static const BorderRadius ${name}BottomRight = .only(bottomRight: $val);')
      ..writeln('static const BorderRadius ${name}TopLeftBottomRight = .only(topLeft: $val, bottomRight: $val);')
      ..writeln('static const BorderRadius ${name}TopRightBottomLeft = .only(topRight: $val, bottomLeft: $val);');
  }

  /// Generates combined border radius configurations using two different values.
  void _generateCombinedBorders(StringBuffer buffer, String name, String val, Map<String, String> fields) {
    for (final MapEntry(:key, :value) in fields.entries) {
      if (name == key) continue;

      final pascalName = key.pascalCase;
      final radiusValue = _formatRadius(value);

      buffer
        ..writeln(
          'static const BorderRadius ${name}Top${pascalName}Left = .only(topLeft: $val, topRight: $radiusValue);',
        )
        ..writeln(
          'static const BorderRadius ${name}Right${pascalName}Bottom = .only(topRight: $val, bottomLeft: $radiusValue);',
        )
        ..writeln(
          'static const BorderRadius ${name}Top${pascalName}Right = .only(topLeft: $val, bottomRight: $radiusValue);',
        )
        ..writeln(
          'static const BorderRadius ${name}Bottom${pascalName}Bottom = .only(bottomLeft: $val, bottomRight: $radiusValue);',
        );
    }
  }
}

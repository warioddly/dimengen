import 'package:dimengen/src/templates/_template.dart';

/// Template for generating space configurations.
class SpacesTemplate extends Template {
  @override
  String generateFor(Map<String, String> values) {
    final buffer = StringBuffer();

    for (final field in values.entries) {
      final name = field.key;
      final val = field.value;

      buffer
        ..writeln('static const SizedBox $name = SizedBox.square(dimension: $val);')
        ..writeln('static const SizedBox ${name}Vertical = SizedBox(height: $val);')
        ..writeln('static const SizedBox ${name}Horizontal = SizedBox(width: $val);');
    }

    buffer
      ..writeln('\n')
      ..writeln('static SizedBox h(double value) => SizedBox(height: value);')
      ..writeln('static SizedBox w(double value) => SizedBox(width: value);')
      ..writeln('static SizedBox square(double value) => SizedBox.square(dimension: value);');

    return buffer.toString();
  }
}

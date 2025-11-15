import 'package:dimengen/src/templates/_template.dart';

/// Template for generating space configurations.
class SpacesTemplate extends Template {
  @override
  String generateFor(Map<String, String> values) {
    final buffer = StringBuffer();

    for (final MapEntry(:key, :value) in values.entries) {
      buffer
        ..writeln('static const SizedBox $key = .square(dimension: $value);')
        ..writeln('static const SizedBox ${key}Vertical = SizedBox(height: $value);')
        ..writeln('static const SizedBox ${key}Horizontal = SizedBox(width: $value);');
    }

    buffer
      ..writeln('static SizedBox h(double value) => SizedBox(height: value);')
      ..writeln('static SizedBox w(double value) => SizedBox(width: value);')
      ..writeln('static SizedBox square(double value) => .square(dimension: value);');

    return buffer.toString();
  }
}

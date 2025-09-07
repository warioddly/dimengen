import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/recase.dart';

/// Template for generating border radius configurations.
class BordersTemplate extends Template {

  static const _templates = <String, String>{
    '': 'BorderRadius.all({val})',
    'Top': 'BorderRadius.only(topLeft: {val}, topRight: {val})',
    'Bottom': 'BorderRadius.only(bottomLeft: {val}, bottomRight: {val})',
    'Left': 'BorderRadius.only(topLeft: {val}, bottomLeft: {val})',
    'Right': 'BorderRadius.only(topRight: {val}, bottomRight: {val})',
    'Vertical': 'BorderRadius.vertical(top: {val}, bottom: {val})',
    'Horizontal': 'BorderRadius.horizontal(left: {val}, right: {val})',
    'TopLeft': 'BorderRadius.only(topLeft: {val})',
    'TopRight': 'BorderRadius.only(topRight: {val})',
    'BottomLeft': 'BorderRadius.only(bottomLeft: {val})',
    'BottomRight': 'BorderRadius.only(bottomRight: {val})',
    'TopLeftBottomRight': 'BorderRadius.only(topLeft: {val}, bottomRight: {val})',
    'TopRightBottomLeft': 'BorderRadius.only(topRight: {val}, bottomLeft: {val})',
  };

  @override
  String generateFor(Map<String, String> values) {

    final buffer = StringBuffer();

    for (final entry in values.entries) {
      final name = entry.key;
      final val = 'Radius.circular(${entry.value})';

      for (final tpl in _templates.entries) {
        final suffix = tpl.key;
        final template = tpl.value.replaceAll('{val}', val);
        buffer.writeln('static const BorderRadius $name$suffix = $template;');
      }
    }

    final keys = values.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      for (var j = 0; j < keys.length; j++) {
        if (i == j) continue;

        final k1 = keys[i];
        final k2 = keys[j].pascalCase;
        final v1 = 'Radius.circular(${values[k1]})';
        final v2 = 'Radius.circular(${values[keys[j]]})';

        buffer.writeln('static const BorderRadius ${k1}Top${k2}Left = BorderRadius.only(topLeft: $v1, topRight: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Right${k2}Bottom = BorderRadius.only(topRight: $v1, bottomLeft: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Top${k2}Right = BorderRadius.only(topLeft: $v1, bottomRight: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Bottom${k2}Bottom = BorderRadius.only(bottomLeft: $v1, bottomRight: $v2);');
      }
    }

    return buffer.toString();
  }
}

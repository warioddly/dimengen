import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/exceptions.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:dimengen/src/utils/recase.dart';
import 'package:dimengen/src/utils/resolver.dart' as resolver;
import 'package:source_gen/source_gen.dart';


/// Generates a class with static constants for various border radius configurations.
class BordersGenerator extends GeneratorForAnnotation<Bordergen> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {

    if (element is! ClassElement) {
      throw CanAppliedOnlyForClassError(element);
    }

    final isDimengen = resolver.isDimengen(annotation);
    final generate = annotation.read(isDimengen ? 'generateBorders' : 'generate');

    if (generate.isNull || !generate.boolValue) {
      return '';
    }

    final className = resolver.resolveClassName(
      isDimengen ? 'bordersName' : 'name',
      annotation,
    );

    final buffer = StringBuffer();

    buffer.writeln(defaultHeader);
    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');
    _generateBorderRadius(element, buffer);
    buffer.writeln('}');

    return buffer.toString();
  }

  void _generateBorderRadius(ClassElement element, StringBuffer buffer) {
    final Map<String, double> values = {};

    for (final field in element.fields) {

      if (!resolver.canGenerateForField(field)) {
        continue;
      }

      final val = field.computeConstantValue()?.toDoubleValue();
      if (val != null) {
        values[field.name] = val;
      }
    }

    for (final entry in values.entries) {
      final name = entry.key;
      final val = 'Radius.circular(${entry.value})';

      buffer.writeln('static const BorderRadius $name = BorderRadius.all($val);');
      buffer.writeln('static const BorderRadius ${name}Top = BorderRadius.only(topLeft: $val, topRight: $val);');
      buffer.writeln('static const BorderRadius ${name}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $val);');
      buffer.writeln('static const BorderRadius ${name}Left = BorderRadius.only(topLeft: $val, bottomLeft: $val);');
      buffer.writeln('static const BorderRadius ${name}Right = BorderRadius.only(topRight: $val, bottomRight: $val);');
      buffer.writeln('static const BorderRadius ${name}Vertical = BorderRadius.vertical(top: $val, bottom: $val);');
      buffer.writeln('static const BorderRadius ${name}Horizontal = BorderRadius.horizontal(left: $val, right: $val);');

      buffer.writeln('static const BorderRadius ${name}TopLeft = BorderRadius.only(topLeft: $val);');
      buffer.writeln('static const BorderRadius ${name}TopRight = BorderRadius.only(topRight: $val);');
      buffer.writeln('static const BorderRadius ${name}BottomLeft = BorderRadius.only(bottomLeft: $val);');
      buffer.writeln('static const BorderRadius ${name}BottomRight = BorderRadius.only(bottomRight: $val);');

      buffer.writeln('static const BorderRadius ${name}TopLeftBottomRight = BorderRadius.only(topLeft: $val, bottomRight: $val);');
      buffer.writeln('static const BorderRadius ${name}TopRightBottomLeft = BorderRadius.only(topRight: $val, bottomLeft: $val);');

      for (final e2 in values.entries) {
        final k1 = name;
        final k2 = e2.key, v2 = 'Radius.circular(${e2.value})';

        if (k1 == k2) continue;

        final k2PascalCased = k2.pascalCase;

        buffer.writeln('static const BorderRadius ${k1}Top${k2PascalCased}Left = BorderRadius.only(topLeft: $val, topRight: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Right${k2PascalCased}Bottom = BorderRadius.only(topRight: $val, bottomLeft: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Top${k2PascalCased}Right = BorderRadius.only(topLeft: $val, bottomRight: $v2);');
        buffer.writeln('static const BorderRadius ${k1}Bottom${k2PascalCased}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $v2);');

      }

    }

  }
}
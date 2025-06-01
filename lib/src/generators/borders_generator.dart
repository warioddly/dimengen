import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
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
      throw InvalidGenerationSource(
        '`@Bordergen` can only be applied to classes',
        element: element,
      );
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

    if (!isDimengen) {
      buffer.writeln(defaultHeader);
    }

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');
    _generateBorderRadius(element, buffer);
    buffer.writeln('\n}');

    return buffer.toString();
  }

  void _generateBorderRadius(ClassElement element, StringBuffer buffer) {
    const borderRadiusDeclaration = 'static const BorderRadius';

    final values = resolver.getFieldValues(element);

    for (final entry in values.entries) {
      final name = entry.key;
      final val = 'Radius.circular(${entry.value})';

      buffer.writeln('$borderRadiusDeclaration $name = BorderRadius.all($val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Top = BorderRadius.only(topLeft: $val, topRight: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Left = BorderRadius.only(topLeft: $val, bottomLeft: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Right = BorderRadius.only(topRight: $val, bottomRight: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Vertical = BorderRadius.vertical(top: $val, bottom: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}Horizontal = BorderRadius.horizontal(left: $val, right: $val);');

      buffer.writeln('$borderRadiusDeclaration ${name}TopLeft = BorderRadius.only(topLeft: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}TopRight = BorderRadius.only(topRight: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}BottomLeft = BorderRadius.only(bottomLeft: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}BottomRight = BorderRadius.only(bottomRight: $val);');

      buffer.writeln('$borderRadiusDeclaration ${name}TopLeftBottomRight = BorderRadius.only(topLeft: $val, bottomRight: $val);');
      buffer.writeln('$borderRadiusDeclaration ${name}TopRightBottomLeft = BorderRadius.only(topRight: $val, bottomLeft: $val);');

      for (final e2 in values.entries) {
        final k1 = name;
        final k2 = e2.key, v2 = 'Radius.circular(${e2.value})';

        if (k1 == k2) continue;

        final k2PascalCased = k2.pascalCase;

        buffer.writeln('$borderRadiusDeclaration ${k1}Top${k2PascalCased}Left = BorderRadius.only(topLeft: $val, topRight: $v2);');
        buffer.writeln('$borderRadiusDeclaration ${k1}Right${k2PascalCased}Bottom = BorderRadius.only(topRight: $val, bottomLeft: $v2);');
        buffer.writeln('$borderRadiusDeclaration ${k1}Top${k2PascalCased}Right = BorderRadius.only(topLeft: $val, bottomRight: $v2);');
        buffer.writeln('$borderRadiusDeclaration ${k1}Bottom${k2PascalCased}Bottom = BorderRadius.only(bottomLeft: $val, bottomRight: $v2);');

      }

    }

  }
}
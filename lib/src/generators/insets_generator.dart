import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/take_generator.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:dimengen/src/utils/recase.dart';
import 'package:dimengen/src/utils/resolver.dart' as resolver;
import 'package:source_gen/source_gen.dart';

/// Generates a class with static constants for various insets configurations.
class InsetsGenerator extends GeneratorForAnnotation<Insetgen> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSource(
        '`@Insetgen` can only be applied to classes',
        element: element,
      );
    }

    final isDimengen = resolver.isDimengen(annotation);
    final generate = annotation.read(
      isDimengen ? 'generateInsets' : 'generate',
    );

    if (generate.isNull || !generate.boolValue) {
      return '';
    }

    final className = resolver.resolveClassName(
      isDimengen ? 'insetsName' : 'name',
      annotation,
    );

    final buffer = StringBuffer();

    if (!isDimengen) {
      buffer.writeln(defaultHeader);
    }

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');
    _generateInsets(element, buffer);

    final taken = await TakeGenerator.generate(buildStep);
    buffer.writeln('\n$taken');

    buffer.writeln('\n}');

    return buffer.toString();
  }

  void _generateInsets(ClassElement element, StringBuffer buffer) {
    const edgeInsetsDeclaration = 'static const EdgeInsets';

    final values = resolver.getFieldValues(element);

    for (final entry in values.entries) {
      final name = entry.key;
      final val = entry.value;

      buffer.writeln('$edgeInsetsDeclaration $name = EdgeInsets.all($val);');
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Top = EdgeInsets.only(top: $val);',
      );
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Bottom = EdgeInsets.only(bottom: $val);',
      );
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Left = EdgeInsets.only(left: $val);',
      );
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Right = EdgeInsets.only(right: $val);',
      );
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Vertical = EdgeInsets.symmetric(vertical: $val);',
      );
      buffer.writeln(
        '$edgeInsetsDeclaration ${name}Horizontal = EdgeInsets.symmetric(horizontal: $val);',
      );

      for (final e2 in values.entries) {
        final k2 = e2.key, v2 = e2.value;

        if (name == k2) continue;

        final k2PascalCased = k2.pascalCase;

        buffer.writeln(
          '$edgeInsetsDeclaration ${name}Top${k2PascalCased}Bottom = EdgeInsets.only(top: $val, bottom: $v2);',
        );
        buffer.writeln(
          '$edgeInsetsDeclaration ${name}Left${k2PascalCased}Right = EdgeInsets.only(left: $val, right: $v2);',
        );
        buffer.writeln(
          '$edgeInsetsDeclaration ${name}Top${k2PascalCased}Left = EdgeInsets.only(top: $val, left: $v2);',
        );
        buffer.writeln(
          '$edgeInsetsDeclaration ${name}Right${k2PascalCased}Bottom = EdgeInsets.only(right: $val, bottom: $v2);',
        );
      }
    }
  }
}

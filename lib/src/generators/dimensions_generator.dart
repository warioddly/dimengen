import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/_generator.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/templates/borders_template.dart';
import 'package:dimengen/src/templates/insets_template.dart';
import 'package:dimengen/src/templates/spaces_template.dart';
import 'package:dimengen/src/utils/extractor.dart';
import 'package:dimengen/src/utils/header.dart' show defaultHeader;
import 'package:dimengen/src/utils/recase.dart';
import 'package:dimengen/src/utils/resolver.dart';
import 'package:source_gen/source_gen.dart' hide Generator;

/// Generates a class with static constants for various dimension configurations.
class DimensionsGenerator extends GeneratorForAnnotation<Dimengen> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    throwInvalidSourceError(element, 'Dimengen');

    final fields = {
      ...await extractFinalValues(buildStep),
      ...extractElementValues(element as ClassElement),
    };

    String generate(Template template, String clazz) {
      final generateClass = annotation.read('generate${clazz.pascalCase}');

      if (!generateClass.boolValue) {
        return '';
      }

      final className = resolveClassName('${clazz}Name', annotation);

      final buffer = StringBuffer();

      buffer
        ..writeln('''
        abstract class $className {
            const $className._();\n
      ''')
        ..writeln(template.generateFor(fields))
        ..writeln('\n}');

      return buffer.toString();
    }

    final result = [
      generate(InsetsTemplate(), 'insets'),
      generate(SpacesTemplate(), 'spaces'),
      generate(BordersTemplate(), 'borders'),
    ];

    if (result.isEmpty) {
      return '';
    }

    final buffer = StringBuffer()
      ..writeln(defaultHeader)
      ..writeln(result.join('\n\n'));

    return buffer.toString();
  }
}

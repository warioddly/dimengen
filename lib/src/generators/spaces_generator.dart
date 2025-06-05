import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/templates/spaces_template.dart';
import 'package:dimengen/src/utils/extractor.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:dimengen/src/utils/resolver.dart' as resolver;
import 'package:source_gen/source_gen.dart';

/// Generates a class with static constants for various spacing configurations.
class SpacesGenerator extends GeneratorForAnnotation<Spacegen> {

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {

    if (element is! ClassElement) {
      throw InvalidGenerationSource(
        '`@Spacegen` can only be applied to classes',
        element: element,
      );
    }

    final isDimengen = resolver.isDimengen(annotation);
    final generate = annotation.read(isDimengen ? 'generateSpaces' : 'generate');

    if (generate.isNull || !generate.boolValue) {
      return '';
    }

    final className = resolver.resolveClassName(
      isDimengen ? 'spacesName' : 'name',
      annotation,
    );

    final buffer = StringBuffer();
    final template = SpacesTemplate();

    if (!isDimengen) {
      buffer.writeln(defaultHeader);
    }

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');

    final fields = {
      ...await extractFinalValues(buildStep),
      ...extractElementValues(element),
    };

    buffer.writeln(template.generateFor(fields));

    final taken = await extractTakeSource(buildStep);
    buffer.writeln('\n$taken');

    buffer.writeln('\n}');

    return buffer.toString();
  }

}
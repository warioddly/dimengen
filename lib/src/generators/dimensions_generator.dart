import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/borders_generator.dart';
import 'package:dimengen/src/generators/insets_generator.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dimengen/src/utils/header.dart' show defaultHeader;

/// Generates a class with static constants for various dimension configurations.
class DimensionsGenerator extends GeneratorForAnnotation<Dimengen> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSource(
        '`@Dimengen` can only be applied to classes',
        element: element,
      );
    }

    final insetgen = InsetsGenerator();
    final spacegen = SpacesGenerator();
    final bordergen = BordersGenerator();

    final buffer = StringBuffer();

    final result = await Future.wait([
      insetgen.generateForAnnotatedElement(element, annotation, buildStep),
      bordergen.generateForAnnotatedElement(element, annotation, buildStep),
      spacegen.generateForAnnotatedElement(element, annotation, buildStep),
    ]);

    buffer
      ..writeln(defaultHeader)
      ..writeln(result.join('\n\n'));

    return buffer.toString();
  }
}

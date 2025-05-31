import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/exceptions.dart';
import 'package:dimengen/src/generators/borders_generator.dart';
import 'package:dimengen/src/generators/insets_generator.dart';
import 'package:dimengen/src/generators/spaces_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dimengen/src/utils/header.dart' show defaultHeader;

/// Generates a class with static constants for various dimension configurations.
class DimensionsGenerator extends GeneratorForAnnotation<Dimengen> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw CanAppliedOnlyForClassError(element);
    }

    final insetgen = InsetsGenerator();
    final spacegen = SpacesGenerator();
    final bordergen = BordersGenerator();

    final buffer = StringBuffer();

    buffer.writeln(defaultHeader);
    buffer.writeln(
      insetgen.generateForAnnotatedElement(element, annotation, buildStep),
    );
    buffer.writeln(
      bordergen.generateForAnnotatedElement(element, annotation, buildStep),
    );
    buffer.writeln(
      spacegen.generateForAnnotatedElement(element, annotation, buildStep),
    );

    return buffer.toString();
  }
}

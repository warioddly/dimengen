import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/generators/take_generator.dart';
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

    if (!isDimengen) {
      buffer.writeln(defaultHeader);
    }

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');

    const sizedBoxDeclaration = 'static const SizedBox';

    for (final field in element.fields) {

      if (!resolver.canGenerateForField(field)) {
        continue;
      }

      final val = field.computeConstantValue()?.toDoubleValue();
      if (val != null) {
        buffer.writeln('$sizedBoxDeclaration ${field.name} = SizedBox.square(dimension: $val);');
        buffer.writeln('$sizedBoxDeclaration ${field.name}Vertical = SizedBox(height: $val);');
        buffer.writeln('$sizedBoxDeclaration ${field.name}Horizontal = SizedBox(width: $val);');
      }
    }

    buffer.writeln('\n');
    buffer.writeln('static SizedBox h(double value) => SizedBox(height: value);');
    buffer.writeln('static SizedBox w(double value) => SizedBox(width: value);');

    final taken = await TakeGenerator.generate(buildStep);
    buffer.writeln('\n$taken');

    buffer.writeln('\n}');

    return buffer.toString();
  }

}
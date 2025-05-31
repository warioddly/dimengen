import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/exceptions.dart';
import 'package:dimengen/src/utils/recase.dart';
import 'package:dimengen/src/utils/resolver.dart';
import 'package:source_gen/source_gen.dart';

class SpacesGenerator extends GeneratorForAnnotation<Dimengen> {

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {

    if (element is! ClassElement) {
      throw CanAppliedOnlyForClassError(element);
    }

    final generateSpaces = annotation.read('generateSpaces');

    if (generateSpaces.isNull || !generateSpaces.boolValue) {
      return '';
    }

    final className = resolveClassName(
      'spacesName',
      'Spaces',
      element,
      annotation,
    );

    final buffer = StringBuffer();

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');

    for (final field in element.fields) {

      if (!canGenerateForField(field)) {
        continue;
      }

      final val = field.computeConstantValue()?.toDoubleValue();
      if (val != null) {
        buffer.writeln('static const SizedBox ${field.name} = SizedBox.square(dimension: $val);');
        buffer.writeln('static const SizedBox ${field.name}Vertical = SizedBox(height: $val);');
        buffer.writeln('static const SizedBox ${field.name}Horizontal = SizedBox(width: $val);');
      }
    }

    buffer.writeln('static SizedBox h(double value) => SizedBox(height: value);');
    buffer.writeln('static SizedBox w(double value) => SizedBox(width: value);');

    buffer.writeln('}');

    return buffer.toString();
  }

}
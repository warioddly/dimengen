import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/exceptions.dart';
import 'package:source_gen/source_gen.dart';


class BorderSideGenerator extends GeneratorForAnnotation<Dimengen> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {

    if (element is! ClassElement) {
      throw CanAppliedOnlyForClassError(element);
    }

    if (!annotation.read('generateBorder').boolValue) {
      return '';
    }

    final borderName = annotation.read('borderName').stringValue;

    if (borderName.isEmpty) {
      throw InvalidGenerationSourceError('borderName cannot be empty.');
    }


    final buffer = StringBuffer();

    final className = element.name;

    buffer.writeln('abstract class $borderName$className {');
    buffer.writeln('  const $borderName$className._();\n');
    _generateBorders(element, buffer);
    buffer.writeln('}');

    return buffer.toString();
  }

  void _generateBorders(ClassElement element, StringBuffer buffer) {
    final Map<String, double> values = {};

    for (final field in element.fields) {
      if (!field.isConst || !field.isStatic || !field.type.isDartCoreDouble) {
        continue;
      }

      final val = field.computeConstantValue()?.toDoubleValue();
      if (val != null) {
        values[field.name] = val;
      }
    }

    for (final entry in values.entries) {
      final name = entry.key;
      final val = entry.value;

      buffer.writeln('static const BorderSide ${name}Top = BorderSide(width: $val);');
      buffer.writeln('static const BorderSide ${name}Bottom = BorderSide(width: $val);');
      buffer.writeln('static const BorderSide ${name}Left = BorderSide(width: $val);');
      buffer.writeln('static const BorderSide ${name}Right = BorderSide(width: $val);');
      buffer.writeln('static const BorderSide $name = BorderSide(width: $val);');
    }
  }
}
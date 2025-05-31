import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/src/exceptions.dart';
import 'package:dimengen/src/utils/recase.dart';
import 'package:dimengen/src/utils/resolver.dart';
import 'package:source_gen/source_gen.dart';

class InsetsGenerator extends GeneratorForAnnotation<Dimengen> {

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {

    if (element is! ClassElement) {
      throw CanAppliedOnlyForClassError(element);
    }

    final generateInsets = annotation.read('generateInsets');

    if (generateInsets.isNull || !generateInsets.boolValue) {
      return '';
    }

    final className = resolveClassName(
      'insetsName',
      'Insets',
      element,
      annotation,
    );

    final buffer = StringBuffer();

    buffer.writeln('abstract class $className {');
    buffer.writeln('  const $className._();\n');
    _generateInsets(element, buffer);
    buffer.writeln('}');

    return buffer.toString();
  }

  void _generateInsets(ClassElement element, StringBuffer buffer) {
    final Map<String, double> values = {};

    for (final field in element.fields) {

      if (!canGenerateForField(field)) {
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

      buffer.writeln('static const EdgeInsets $name = EdgeInsets.all($val);');
      buffer.writeln('static const EdgeInsets ${name}Top = EdgeInsets.only(top: $val);');
      buffer.writeln('static const EdgeInsets ${name}Bottom = EdgeInsets.only(bottom: $val);');
      buffer.writeln('static const EdgeInsets ${name}Left = EdgeInsets.only(left: $val);');
      buffer.writeln('static const EdgeInsets ${name}Right = EdgeInsets.only(right: $val);');
      buffer.writeln('static const EdgeInsets ${name}Vertical = EdgeInsets.symmetric(vertical: $val);');
      buffer.writeln('static const EdgeInsets ${name}Horizontal = EdgeInsets.symmetric(horizontal: $val);');

      for (final e2 in values.entries) {
        final k1 = name, v1 = val;
        final k2 = e2.key, v2 = e2.value;

        if (k1 == k2) continue;

        final k2PascalCased = k2.pascalCase;

        buffer.writeln('static const EdgeInsets ${k1}Top${k2PascalCased}Bottom = EdgeInsets.only(top: $v1, bottom: $v2);');
        buffer.writeln('static const EdgeInsets ${k1}Left${k2PascalCased}Right = EdgeInsets.only(left: $v1, right: $v2);');
        buffer.writeln('static const EdgeInsets ${k1}Top${k2PascalCased}Left = EdgeInsets.only(top: $v1, left: $v2);');
        buffer.writeln('static const EdgeInsets ${k1}Right${k2PascalCased}Bottom = EdgeInsets.only(right: $v1, bottom: $v2);');
      }


    }

  }

}
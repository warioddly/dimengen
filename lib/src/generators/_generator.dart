import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dimengen/src/templates/_template.dart';
import 'package:dimengen/src/utils/extractor.dart';
import 'package:dimengen/src/utils/header.dart';
import 'package:dimengen/src/utils/resolver.dart';
import 'package:source_gen/source_gen.dart';

void thowInvalidSourceError(Element element, String className) {
  if (element is! ClassElement) {
    throw InvalidGenerationSource(
      '`@$className` can only be applied to classes',
      element: element,
    );
  }
}

abstract class Generator<T> extends GeneratorForAnnotation<T> {

  Template get template;

  String get metaName;

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    thowInvalidSourceError(element, metaName);

    final className = resolveClassName('name', annotation);

    final buffer = StringBuffer();

    buffer.writeln('''
        $defaultHeader\n
        abstract class $className {
            const $className._();\n
    ''');

    final fields = {
      ...await extractFinalValues(buildStep),
      ...extractElementValues(element as ClassElement),
    };

    buffer.writeln(template.generateFor(fields));
    buffer.writeln('\n}');

    return buffer.toString();
  }
}

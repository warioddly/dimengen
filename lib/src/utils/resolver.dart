import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';


String resolveClassName(
  String key,
  String defaultName,
  ClassElement element,
  ConstantReader annotation,
) {
  final className = annotation.read(key);

  if (className.isString && className.stringValue.isEmpty) {
    throw InvalidGenerationSourceError('$key cannot be empty.');
  }

  return className.isNull
      ? '$defaultName${element.name}'
      : className.stringValue;
}

bool canGenerateForField(FieldElement field) {
  return field.isStatic && field.isConst && field.type.isDartCoreDouble;
}

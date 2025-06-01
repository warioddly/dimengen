import 'package:analyzer/dart/element/element.dart';
import 'package:dimengen/dimengen.dart' show Dimengen;
import 'package:source_gen/source_gen.dart';

/// Resolves the class name based on the provided key and default name.
String resolveClassName(
  String key,
  ConstantReader annotation,
) {
  final className = annotation.read(key);

  if (className.isString && className.stringValue.isEmpty) {
    throw InvalidGenerationSourceError('$key cannot be empty.');
  }

  return className.stringValue;
}

/// Checks if the field is a valid candidate for generating dimensions.
bool canGenerateForField(FieldElement field) {
  return field.isStatic && field.isConst && field.type.isDartCoreDouble;
}

/// Checks if the annotation is an instance of Dimengen.
bool isDimengen(ConstantReader annotation) {
  return annotation.instanceOf(const TypeChecker.fromRuntime(Dimengen));
}


/// Retrieves the field values from a class element that can be used for dimension generation.
Map<String, double> getFieldValues(ClassElement element) {
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

  return values;
}

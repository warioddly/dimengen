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

/// Checks if the annotation is an instance of Dimengen.
bool isDimengen(ConstantReader annotation) =>
    annotation.instanceOf(const TypeChecker.fromRuntime(Dimengen));

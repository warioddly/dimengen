
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// Exception thrown when `@Dimengen` is applied to an element that is not a class.
class CanAppliedOnlyForClassError extends InvalidGenerationSourceError {

  /// Creates an instance of [CanAppliedOnlyForClassError].
  CanAppliedOnlyForClassError(Element element) : super(
    '`@Dimengen` can only be applied to classes',
    element: element,
  );

}
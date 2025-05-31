
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

class CanAppliedOnlyForClassError extends InvalidGenerationSourceError {

  CanAppliedOnlyForClassError(Element element) : super(
    '`@Dimengen` can only be applied to classes',
    element: element,
  );

}
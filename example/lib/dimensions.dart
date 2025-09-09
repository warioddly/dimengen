import 'package:dimengen/dimengen.dart';
import 'package:flutter/cupertino.dart';

part 'dimensions.g.dart';

@Dimengen(
  spacesName: 'DesignSpaces',
  insetsName: 'Insets'
)
abstract final class Dimensions {
  Dimensions._();

  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
}

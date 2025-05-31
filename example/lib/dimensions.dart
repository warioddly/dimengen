import 'package:dimengen/dimengen.dart';
import 'package:flutter/cupertino.dart';

part 'dimensions.g.dart';

@Dimengen()
abstract final class Dimensions {
  Dimensions._();

  static const double zero = 0.0;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

import 'package:dimengen/dimengen.dart';
import 'package:flutter/cupertino.dart';

part 'borders.g.dart';

abstract class Border {
  final double m = 16.0;
  int get xsl => 22;
}

@Bordergen()
abstract class _Borders extends Border {
  _Borders._();

  final int xl = 28;
  static const double s = 24.0;
}

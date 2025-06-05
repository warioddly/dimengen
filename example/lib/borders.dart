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

  @take
  static const BorderRadius customTakeProperty = BorderRadius.only(
    topLeft: Radius.circular(_Borders.s),
    topRight: Radius.circular(_Borders.s),
  );


  @take
  static String hello() => 'Hello World!';

  @take
  static get getBorder => BorderRadius.all(Radius.circular(_Borders.s));

}
import 'package:dimengen/dimengen.dart';
import 'package:flutter/cupertino.dart';

part 'borders.g.dart';

@Bordergen()
abstract class _Borders {
  _Borders._();

  static const double s = 24.0;

  @take
  static const BorderRadius sTop = BorderRadius.only(
    topLeft: Radius.circular(_Borders.s),
    topRight: Radius.circular(_Borders.s),
  );

}
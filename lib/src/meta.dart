
class Dimengen {

  const Dimengen({
    this.insetsName,
    this.borderRadiusName,
    this.spacesName,
    this.generateInsets = true,
    this.generateBorderRadius = true,
    this.generateSpaces = true,
  });

  final bool generateInsets;
  final bool generateBorderRadius;
  final bool generateSpaces;
  final String? insetsName;
  final String? borderRadiusName;
  final String? spacesName;

}

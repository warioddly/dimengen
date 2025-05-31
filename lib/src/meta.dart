
class Dimengen {

  const Dimengen({
    this.insetsName,
    this.borderName,
    this.borderRadiusName,
    this.spacesName,
    this.generateInsets = true,
    this.generateBorder = true,
    this.generateBorderRadius = true,
    this.generateSpaces = true,
  });

  final bool generateInsets;
  final bool generateBorder;
  final bool generateBorderRadius;
  final bool generateSpaces;
  final String? insetsName;
  final String? borderName;
  final String? borderRadiusName;
  final String? spacesName;

}

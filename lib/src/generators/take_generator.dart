import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/analysis/utilities.dart';

/// Generates code for fields and methods annotated with `@take`.
class TakeGenerator {

  /// Generates a string representation of the code for fields and methods
  static Future<String> generate(BuildStep buildStep) async {

    final buffer = StringBuffer();
    final inputId = buildStep.inputId;

    final parsed = await buildStep.resolver.compilationUnitFor(inputId);
    final result = parsed.toSource();

    final ast = parseString(content: result).unit;

    for (final declaration in ast.declarations) {
      if (declaration is ClassDeclaration) {
        for (final member in declaration.members) {
          final hasTake = member.metadata.any((m) => m.name.name == 'take');

          if ((member is FieldDeclaration || member is MethodDeclaration) && hasTake) {
            final source = member.toSource().replaceAll('@take', '');
            buffer.writeln('\n$source\n');
          }
        }
      }
    }

    return buffer.toString();
  }

}
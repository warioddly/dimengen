import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart' show ClassElement;
import 'package:build/build.dart';

/// Retrieves the field values from a class element that can be used for dimension generation.
Map<String, String> extractElementValues(ClassElement element) {
  final Map<String, String> values = {};

  for (final field in element.fields) {
    if ((field.type.isDartCoreDouble || field.type.isDartCoreInt)) {
      final val = field.computeConstantValue()?.toDoubleValue();
      if (val != null) {
        values[field.name] = '$val';
      }
    }
  }

  return values;
}

/// Retrieves the final values from a build step, parsing the source code
Future<Map<String, String>> extractFinalValues(BuildStep buildStep) async {
  final values = <String, String>{};
  final inputId = buildStep.inputId;

  final parsed = await buildStep.resolver.compilationUnitFor(inputId);
  final result = parsed.toSource();

  final ast = parseString(content: result).unit;

  for (final declarations in ast.declarations) {
    if (declarations is ClassDeclaration) {
      for (final member in declarations.members) {
        if (member is FieldDeclaration) {
          for (final variable in member.fields.variables
              .where((variable) => variable.isFinal)) {
            if (variable.isFinal) {
              final initializer = variable.initializer;

              final isValidType =
                  initializer is IntegerLiteral || initializer is DoubleLiteral;

              if (isValidType) {
                final name = variable.name.lexeme;
                values[name] = initializer!.toSource();
              }
            }
          }
        } else if (member is MethodDeclaration && member.isGetter) {
          final body = member.body;

          if (body is ExpressionFunctionBody) {
            final expression = body.expression;

            final isValidType =
                expression is IntegerLiteral || expression is DoubleLiteral;

            if (isValidType) {
              final name = member.name.lexeme;
              values[name] = expression.toSource();
            }
          }
        }
      }
    }
  }

  return values;
}

/// Extracts the source code of fields and methods annotated with `@take`.
Future<String> extractTakeSource(BuildStep buildStep) async {

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
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' as e;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectFontWeight extends DartLintRule {
  AvoidDirectFontWeight() : super(code: _code);

  static final _code = LintCode(
    name: 'avoid_direct_font_weight',
    problemMessage: 'Avoid using FontWeight directly. Use CustomFontWeight instead.',
    correctionMessage: 'Replace FontWeight with CustomFontWeight',
    errorSeverity: e.ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addSimpleIdentifier((node) {
      if (node.name == 'FontWeight' && node.parent is! PrefixedIdentifier) {
        final element = node.staticElement;
        if (element != null && element.library?.source.uri.toString() == 'dart:ui') {
          reporter.atNode(node, code);
        }
      }
    });

    context.registry.addPrefixedIdentifier((node) {
      if (node.prefix.name == 'FontWeight') {
        final element = node.prefix.staticElement;
        if (element != null && element.library?.source.uri.toString() == 'dart:ui') {
          reporter.atNode(node.prefix, code);
        }
      }
    });
  }
}

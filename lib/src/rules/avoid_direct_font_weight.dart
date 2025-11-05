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
    errorSeverity: e.DiagnosticSeverity.ERROR,
  );

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    context.registry.addSimpleIdentifier((node) {
      if (node.name == 'FontWeight' && node.parent is! PrefixedIdentifier) {
        // Check if this refers to the FontWeight class
        final element = node.element;
        if (element != null) {
          // Check the element type and library
          final library = element.library;
          if (library != null) {
            final libraryId = library.identifier;
            // Check if it's from dart:ui or Flutter packages
            // Flutter re-exports dart:ui's FontWeight through material.dart, widgets.dart, etc.
            if (libraryId.startsWith('dart:ui') ||
                libraryId.contains('flutter/src/painting') ||
                libraryId.contains('package:flutter/')) {
              // Check if we're inside CustomFontWeight class to avoid false positives
              AstNode? current = node;
              bool insideCustomFontWeight = false;
              while (current != null) {
                if (current is ClassDeclaration && current.name.lexeme == 'CustomFontWeight') {
                  insideCustomFontWeight = true;
                  break;
                }
                current = current.parent;
              }
              if (!insideCustomFontWeight) {
                reporter.atNode(node, code);
              }
            }
          }
        }
      }
    });

    context.registry.addPrefixedIdentifier((node) {
      if (node.prefix.name == 'FontWeight') {
        // This handles FontWeight.bold, FontWeight.w100, etc.
        final element = node.prefix.element;
        if (element != null) {
          // Check the element type and library
          final library = element.library;
          if (library != null) {
            final libraryId = library.identifier;
            // Check if it's from dart:ui or Flutter packages
            if (libraryId.startsWith('dart:ui') ||
                libraryId.contains('flutter/src/painting') ||
                libraryId.contains('package:flutter/')) {
              // Check if we're inside CustomFontWeight class to avoid false positives
              AstNode? current = node;
              bool insideCustomFontWeight = false;
              while (current != null) {
                if (current is ClassDeclaration && current.name.lexeme == 'CustomFontWeight') {
                  insideCustomFontWeight = true;
                  break;
                }
                current = current.parent;
              }
              if (!insideCustomFontWeight) {
                reporter.atNode(node.prefix, code);
              }
            }
          }
        }
      }
    });
  }
}

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'src/rules/avoid_direct_font_weight.dart';

PluginBase createPlugin() => _ColorSingLints();

class _ColorSingLints extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        AvoidDirectFontWeight(),
      ];
}
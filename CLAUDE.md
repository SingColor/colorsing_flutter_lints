# ColorSing Flutter Lints プロジェクト

## プロジェクト概要

ColorSing Flutter アプリケーション用のカスタム Lint ルール集です。このプロジェクトは `custom_lint_builder` を使用して、プロジェクト固有のコーディング規約を強制するための Lint ルールを提供します。

## 技術スタック

- Dart SDK: >=3.0.0 <4.0.0
- Flutter: stable (FVM で管理)
- custom_lint_builder: ^0.6.0
- analyzer: ^6.2.0

## プロジェクト構成

```
colorsing_flutter_lints/
├── .fvmrc                           # FVM設定ファイル
├── .gitignore                       # Git除外設定
├── pubspec.yaml                     # パッケージ設定
├── README.md                        # 使用方法ドキュメント
├── lib/
│   ├── colorsing_flutter_lints.dart  # Lintプラグインのエントリーポイント
│   └── src/
│       └── rules/                   # Lintルール格納ディレクトリ
│           └── avoid_direct_font_weight.dart
└── example/                         # 動作確認用サンプルプロジェクト
    ├── .fvmrc
    ├── pubspec.yaml
    ├── analysis_options.yaml
    └── lib/
        ├── custom_font_weight.dart
        └── test_font_weight.dart
```

## 実装済み Lint ルール

### avoid_direct_font_weight

`FontWeight`クラスを直接使用することを禁止し、プロジェクト固有の`CustomFontWeight`クラスの使用を強制します。

**検出ロジック:**

- `dart:ui`の`FontWeight`クラスへの参照を検出
- `SimpleIdentifier`と`PrefixedIdentifier`の両方をチェック（重複検出を防ぐ最適化済み）
- エラーレベル: INFO

## 開発時の注意事項

### 1. FVM の使用

このプロジェクトは FVM（Flutter Version Management）を使用しています。コマンド実行時は`fvm`プレフィックスを付けてください：

```bash
fvm flutter pub get
fvm dart run custom_lint
```

### 2. Lint ルールの実装パターン

新しい Lint ルールを追加する際は以下のパターンに従ってください：

```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class YourLintRule extends DartLintRule {
  YourLintRule() : super(code: _code);

  static const _code = LintCode(
    name: 'your_lint_rule_name',
    problemMessage: 'エラーメッセージ',
    correctionMessage: '修正方法の提案',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // AST解析とエラー報告のロジック
  }
}
```

### 3. インポート時の注意

`analyzer`パッケージと`custom_lint_builder`パッケージで同名のクラスが存在する場合があります（例：`LintCode`）。必要に応じて`hide`キーワードを使用してください。

### 4. テスト方法

`example`ディレクトリ内で Lint ルールの動作を確認：

```bash
cd example
fvm dart run custom_lint
```

## トラブルシューティング

### "Failed to start plugins" エラー

Lint ルールのコンパイルエラーが原因です。以下を確認してください：

1. インポート文が正しいか
2. クラス名の競合がないか
3. LintCode の引数が正しいか

### 重複した警告が表示される

AST ノードの親子関係により、同じコードが複数回検出される場合があります。`node.parent`をチェックして重複を防いでください。

## 今後の拡張予定

- 追加のカスタム Lint ルール
- Quick Fix の実装
- ルールごとの設定オプション
- より詳細なエラーメッセージとドキュメント

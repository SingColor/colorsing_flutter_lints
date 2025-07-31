# ColorSing Flutter Lints

ColorSing Flutter アプリケーション用のカスタムLintルール集です。

## セットアップ

### 1. プロジェクトに依存関係を追加

`pubspec.yaml`に以下を追加:

```yaml
dev_dependencies:
  custom_lint: ^0.6.0
  colorsing_flutter_lints:
    path: ../colorsing_flutter_lints  # パスは適宜調整
```

### 2. analysis_options.yaml を設定

プロジェクトのルートに`analysis_options.yaml`を作成し、以下を追加:

```yaml
analyzer:
  plugins:
    - custom_lint
```

### 3. 依存関係をインストール

```bash
flutter pub get
# または
fvm flutter pub get
```

## 利用可能なルール

### avoid_direct_font_weight

`FontWeight`を直接使用することを禁止し、代わりに`CustomFontWeight`の使用を推奨します。

**Bad:**
```dart
Text(
  'Hello',
  style: TextStyle(fontWeight: FontWeight.bold),
)
```

**Good:**
```dart
Text(
  'Hello',
  style: TextStyle(fontWeight: CustomFontWeight.bold),
)
```

## Lintの実行

```bash
dart run custom_lint
# または
fvm dart run custom_lint
```

## 新しいルールの追加

1. `lib/src/rules/`に新しいルールファイルを作成
2. `DartLintRule`を継承したクラスを実装
3. `lib/colorsing_flutter_lints.dart`の`getLintRules`メソッドに追加

import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'common.dart';

/// App theme configuration.
abstract final class AppTheme {
  static ThemeData light() => _common(
        FlexThemeData.light(scheme: FlexScheme.flutterDash),
      );

  static ThemeData dark() => _common(
        FlexThemeData.dark(scheme: FlexScheme.flutterDash),
      );

  static ThemeData _common(ThemeData theme) {
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: true,
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(Margin.xSmall),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

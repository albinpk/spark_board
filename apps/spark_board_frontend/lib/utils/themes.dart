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
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Margin.small),
        ),
      ),
      cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Margin.xSmall),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Margin.small),
          ).toState(),
        ),
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

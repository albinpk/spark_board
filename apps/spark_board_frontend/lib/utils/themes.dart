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
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Margin.xSmall),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        menuPadding: EdgeInsets.zero,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Margin.small),
          ).toState(),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Margin.xSmall),
            ),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Margin.xSmall),
            ),
          ),
        ),
      ),
    );
  }
}

import 'common.dart';

/// App theme configuration.
abstract final class AppTheme {
  static ThemeData light() {
    final theme = FlexThemeData.light(
      scheme: FlexScheme.flutterDash,
    );
    return _common(
      theme.copyWith(
        extensions: [
          SkeletonizerConfigData(
            ignoreContainers: true,
            effect: PulseEffect(
              duration: const Duration(milliseconds: 700),
              from: theme.colorScheme.surface.darken(),
              to: theme.colorScheme.surface.darken(15),
            ),
          ),
        ],
      ),
    );
  }

  static ThemeData dark() {
    final theme = FlexThemeData.dark(
      scheme: FlexScheme.flutterDash,
    );
    return _common(
      theme.copyWith(
        extensions: [
          SkeletonizerConfigData.dark(
            ignoreContainers: true,
            effect: PulseEffect(
              duration: const Duration(milliseconds: 700),
              from: theme.colorScheme.surface.lighten(),
              to: theme.colorScheme.surface.lighten(15),
            ),
          ),
        ],
      ),
    );
  }

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
          backgroundColor: theme.colorScheme.onSurface.fade(0.05),
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

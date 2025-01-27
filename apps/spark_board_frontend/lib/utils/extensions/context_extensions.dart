import 'package:flutter/material.dart';

/// Extensions for theme data.
extension ThemeDataExtension on BuildContext {
  /// Return [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Color scheme from theme data.
  ColorScheme get cs => theme.colorScheme;

  /// Font size: `16.0`.
  TextStyle get bodyLarge => textTheme.bodyLarge!;

  /// Font size: `14.0`.
  TextStyle get bodyMedium => textTheme.bodyMedium!;

  /// Font size: `12.0`.
  TextStyle get bodySmall => textTheme.bodySmall!;

  /// Font size: `96.0`.
  TextStyle get displayLarge => textTheme.displayLarge!;

  /// Font size: `60.0`.
  TextStyle get displayMedium => textTheme.displayMedium!;

  /// Font size: `48.0`.
  TextStyle get displaySmall => textTheme.displaySmall!;

  /// Font size: `40.0`.
  TextStyle get headlineLarge => textTheme.headlineLarge!;

  /// Font size: `34.0`.
  TextStyle get headlineMedium => textTheme.headlineMedium!;

  /// Font size: `24.0`.
  TextStyle get headlineSmall => textTheme.headlineSmall!;

  /// Font size: `14.0`.
  TextStyle get labelLarge => textTheme.labelLarge!;

  /// Font size: `11.0`.
  TextStyle get labelMedium => textTheme.labelMedium!;

  /// Font size: `10.0`.
  TextStyle get labelSmall => textTheme.labelSmall!;

  /// Return `textTheme` from [ThemeData].
  TextTheme get textTheme => theme.textTheme;

  /// Font size: `20.0`.
  TextStyle get titleLarge => textTheme.titleLarge!;

  /// Font size: `16.0`.
  TextStyle get titleMedium => textTheme.titleMedium!;

  /// Font size: `14.0`.
  TextStyle get titleSmall => textTheme.titleSmall!;

  /// Return [light] or [dark] color based on current brightness.
  Color colorOn(Color light, Color dark) {
    return cs.brightness == Brightness.dark ? dark : light;
  }

  /// Disabled text color.
  Color grey([double value = 0.5]) => cs.onSurface.fade(value);
}

/// Extensions for material color.
extension ColorExt on Color {
  /// Handy method for adding opacity.
  Color fade(double value) => withValues(alpha: value);
}

/// Extensions for media query.
extension MediaQueryExt on BuildContext {
  /// Return width of screen.
  double get width => MediaQuery.sizeOf(this).width;
}

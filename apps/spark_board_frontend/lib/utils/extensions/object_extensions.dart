import '../common.dart';

/// Extension methods for [Object].
extension ObjectExt<T> on T {
  /// Converts to [WidgetStatePropertyAll].
  WidgetStatePropertyAll<T> toState() {
    return WidgetStatePropertyAll(this);
  }

  /// Converts to [List] with [length] elements.
  List<T> asList(int length) {
    return List<T>.filled(length, this);
  }
}

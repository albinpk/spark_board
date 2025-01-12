import '../common.dart';

extension ObjectExt<T> on T {
  /// Converts to [WidgetStatePropertyAll].
  WidgetStatePropertyAll<T> toState() {
    return WidgetStatePropertyAll(this);
  }
}

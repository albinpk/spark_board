import '../common.dart';

/// Extension for [ConsumerState] class.
extension ConsumerStateExt on ConsumerState {
  /// Redirect to [WidgetRefExt.go] method.
  void go(String location) => ref.go(location);
}

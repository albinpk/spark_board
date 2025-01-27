import 'common.dart';

/// App snackbar
abstract class AppSnackbar {
  static final key = GlobalKey<ScaffoldMessengerState>(
    debugLabel: 'scaffoldMessengerKey',
  );

  /// Show success snackbar.
  static void success(String message) {
    show(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        // behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show error snackbar.
  static void error([String? message]) {
    show(
      SnackBar(
        content: Text(message ?? 'Something went wrong!'),
        backgroundColor: Colors.red,
        // behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show waring snackbar.
  static void warning(String message) {
    show(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        // behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ScaffoldMessengerState get _state => key.currentState!;

  /// Show raw snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    SnackBar snackbar,
  ) {
    _state.clearSnackBars();
    return _state.showSnackBar(snackbar);
  }
}

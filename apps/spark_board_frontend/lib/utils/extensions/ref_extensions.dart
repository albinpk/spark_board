import 'package:go_router/go_router.dart';

import '../../route/router.dart';
// ignore: unused_import
import '../../route/routes.dart';
import '../common.dart';

extension WidgetRefExt on WidgetRef {
  /// Get go router instance.
  GoRouter get router => read(appRouterProvider);

  /// Get shared preferences instance.
  // SharedPreferences get storage => read(sharedPreferencesProvider).requireValue;

  /// Get api client instance.
  // ApiClient get api => read(apiClientProvider);

  /// Redirect to [GoRouter.go] method.
  /// Usage:
  /// ```dart
  /// ref.go(const LoginRoute().location);
  /// ```
  void go(String location) => router.go(location);
}

extension ProviderRefExt on Ref {
  /// Get go router instance.
  GoRouter get router => read(appRouterProvider);

  /// Get shared preferences instance.
  // SharedPreferences get storage => read(sharedPreferencesProvider).requireValue;

  /// Get api client instance.
  // ApiClient get api => read(apiClientProvider);

  /// Redirect to [GoRouter.go] method.
  /// Usage:
  /// ```dart
  /// ref.go(const LoginRoute().location);
  /// ```
  void go(String location) => router.go(location);
}

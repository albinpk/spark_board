import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../route/router.dart';
import '../../services/api/api_client.dart';
import '../../services/api/api_client_provider.dart';
import '../../services/storage/shared_preferences_provider.dart';
import '../common.dart';

extension WidgetRefExt on WidgetRef {
  /// Get go router instance.
  GoRouter get router => read(appRouterProvider);

  /// Get shared preferences instance.
  SharedPreferences get storage => read(sharedPreferencesProvider).requireValue;

  /// Get api client instance.
  ApiClient get api => read(apiClientProvider);

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
  SharedPreferences get storage => read(sharedPreferencesProvider).requireValue;

  /// Get api client instance.
  ApiClient get api => read(apiClientProvider);

  /// Redirect to [GoRouter.go] method.
  /// Usage:
  /// ```dart
  /// ref.go(const LoginRoute().location);
  /// ```
  void go(String location) => router.go(location);

  /// Get dio cancel token that will be cancelled on dispose.
  CancelToken cancelToken() {
    final cancelToken = CancelToken();
    onDispose(cancelToken.cancel);
    return cancelToken;
  }
}

import 'package:flutter/foundation.dart';

import '../utils/common.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: const LoginRoute(demo: true).location,
      debugLogDiagnostics: kDebugMode,
      routes: $appRoutes,
      redirect: _redirect,
    );
  }

  // ignore: avoid_build_context_in_providers
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    if (state.matchedLocation == const LoginRoute().location ||
        state.matchedLocation == const SignupRoute().location ||
        ref.storage.getString(StorageConstants.token) != null) {
      return null;
    }
    return const LoginRoute().location;
  }
}

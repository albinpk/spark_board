import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../utils/common.dart';

part 'router.g.dart';

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: const LoginRoute().location,
      debugLogDiagnostics: kDebugMode,
      routes: $appRoutes,
      redirect: _redirect,
    );
  }

  // ignore: avoid_build_context_in_providers
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    if (state.matchedLocation == const LoginRoute().location ||
        state.matchedLocation == const SignupRoute().location ||
        ref.storage.getString('token') != null) {
      return null;
    }
    return const LoginRoute().location;
  }
}

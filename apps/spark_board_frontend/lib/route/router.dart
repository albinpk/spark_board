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
      // redirect: _redirect,
    );
  }

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    return const LoginRoute().location;
  }
}

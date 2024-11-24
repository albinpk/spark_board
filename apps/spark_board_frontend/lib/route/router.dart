import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../utils/common.dart';

part 'router.g.dart';

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      routes: $appRoutes,
      redirect: _redirect,
    );
  }

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final token = ref.storage.getString('token');
    if (token == null) {
      if (state.matchedLocation == const LoginRoute().location ||
          state.matchedLocation == const SignupRoute().location) return null;
      return const LoginRoute().location;
    }
    return null;
  }
}

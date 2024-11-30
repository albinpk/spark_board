import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../utils/common.dart';

part 'router.g.dart';

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: const ProjectsRoute().location,
      // initialLocation: const TasksRoute(projectId: '23').location,
      debugLogDiagnostics: kDebugMode,
      routes: $appRoutes,
      redirect: _redirect,
    );
  }

  // ignore: avoid_build_context_in_providers
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final token = ref.storage.getString('token');
    final isLoginOrSignup =
        state.matchedLocation == const LoginRoute().location ||
            state.matchedLocation == const SignupRoute().location;
    if (token == null) {
      if (isLoginOrSignup) return null;
      return const LoginRoute().location;
    }
    if (isLoginOrSignup) {
      return const ProjectsRoute().location;
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../modules/dashboard/dashboard_view.dart';
import '../modules/login/login_view.dart';
import '../modules/signup/signup_view.dart';

part 'routes.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignupView();
}

@TypedGoRoute<DashboardRoute>(path: '/')
class DashboardRoute extends GoRouteData {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardView();
}

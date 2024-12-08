import 'package:go_router/go_router.dart';

import '../modules/dashboard/project_shell.dart';
import '../modules/login/login_view.dart';
import '../modules/project_details/project_details_view.dart';
import '../modules/projects/projects_view.dart';
import '../modules/signup/signup_view.dart';
import '../modules/staff/staff_view.dart';
import '../modules/tasks/tasks_view.dart';
import '../utils/common.dart';

part 'routes.g.dart';

/// URL path.
/// ****************
///
/// Authentication
/// login
/// signup
///
/// Projects
/// projects                 => projects list
/// projects/:id             => project details
///
/// Tasks
/// projects/:id/tasks       => tasks list
/// projects/:id/tasks/:id   => task details
///
/// Staff
/// projects/:id/staff       => staff list
/// projects/:id/staff/:id   => staff details

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

@TypedGoRoute<ProjectsRoute>(
  path: '/projects',
  routes: [
    TypedGoRoute<ProjectDetailsRoute>(
      path: ':projectId',
      routes: [
        TypedShellRoute<ProjectShellRoute>(
          routes: [
            TypedGoRoute<TasksRoute>(path: 'tasks'),
            TypedGoRoute<StaffRoute>(path: 'staff'),
          ],
        ),
      ],
    ),
  ],
)
class ProjectsRoute extends GoRouteData {
  const ProjectsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProjectsView();
}

class ProjectDetailsRoute extends GoRouteData {
  const ProjectDetailsRoute({
    required this.projectId,
  });

  final String projectId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProjectDetailsView(projectId: projectId);
}

class ProjectShellRoute extends ShellRouteData {
  const ProjectShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    final projectId = state.pathParameters['projectId']!;
    return ProjectShell(projectId: projectId, child: navigator);
  }
}

class TasksRoute extends GoRouteData {
  const TasksRoute({
    required this.projectId,
  });

  final String projectId;

  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: TasksView(projectId: projectId));
  }
}

class StaffRoute extends GoRouteData {
  const StaffRoute({
    required this.projectId,
  });

  final String projectId;

  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: StaffView());
  }
}

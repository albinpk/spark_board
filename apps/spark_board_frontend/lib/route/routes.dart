import '../modules/dashboard/project_shell.dart';
import '../modules/login/login_view.dart';
import '../modules/project_details/project_details_view.dart';
import '../modules/projects/projects_view.dart';
import '../modules/signup/signup_view.dart';
import '../modules/staff/staff_view.dart';
import '../modules/task_details/task_details_view.dart';
import '../modules/tasks/tasks_view.dart';
import '../services/api/models/task_details_response.dart';
import '../utils/common.dart';
import 'dialog_view.dart';
import 'router.dart';

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
  const LoginRoute({
    this.next,
  });

  final String? next;

  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: LoginView(nextRoute: next));
  }
}

@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: SignupView());
  }
}

@TypedGoRoute<ProjectsRoute>(
  path: '/projects',
  routes: [
    TypedGoRoute<ProjectDetailsRoute>(
      path: ':projectId',
      routes: [
        TypedShellRoute<ProjectShellRoute>(
          routes: [
            TypedGoRoute<TasksRoute>(
              path: 'tasks',
              routes: [
                TypedGoRoute<TaskDetailsDialogRoute>(path: ':taskId'),
              ],
            ),
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
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: ProjectsView());
  }
}

class ProjectDetailsRoute extends GoRouteData {
  const ProjectDetailsRoute({
    required this.projectId,
  });

  final String projectId;

  @override
  NoTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: ProjectDetailsView(projectId: projectId));
  }
}

class ProjectShellRoute extends ShellRouteData {
  const ProjectShellRoute();

  @override
  NoTransitionPage<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    final projectId = state.pathParameters['projectId']!;
    return NoTransitionPage(
      child: ProjectShell(projectId: projectId, child: navigator),
    );
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

class TaskDetailsDialogRoute extends GoRouteData {
  const TaskDetailsDialogRoute({
    required this.projectId,
    required this.taskId,
  });

  final String projectId;
  final String taskId;

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<TaskDetails> buildPage(BuildContext context, GoRouterState state) {
    return DialogView<TaskDetails>(
      barrierDismissible: false,
      builder: (context) {
        return SizedBox(
          width: 800,
          height: 800,
          child: TaskDetailsView(
            projectId: projectId,
            taskId: taskId,
          ),
        );
      },
    );
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

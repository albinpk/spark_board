import 'package:go_router/go_router.dart';

import '../../utils/common.dart';
import '../../widgets/nested_navigation_rail.dart';
import '../project_bar/project_bar_view.dart';

/// Project shell widget for go router.
class ProjectShell extends StatelessWidget {
  const ProjectShell({
    required this.projectId,
    required this.child,
    super.key,
  });

  /// Project id.
  final String projectId;

  /// Route widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final url = GoRouter.of(context).state!.uri.toString();

    bool isStartsWith(String path) =>
        url.startsWith('/projects/$projectId/$path');

    return Material(
      child: Column(
        children: [
          ProjectBarView(projectId: projectId),
          Expanded(
            child: Row(
              children: [
                NestedNavigationRail(
                  items: [
                    NavItem(
                      icon: const Icon(Icons.checklist),
                      isSelected: isStartsWith('tasks'),
                      label: 'Tasks',
                      onTap: () {
                        TasksRoute(projectId: projectId).go(context);
                      },
                    ),
                    NavItem(
                      icon: const Icon(Icons.person),
                      isSelected: isStartsWith('users'),
                      label: 'Users',
                      onTap: () {
                        UsersRoute(projectId: projectId).go(context);
                      },
                    ),
                  ],
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

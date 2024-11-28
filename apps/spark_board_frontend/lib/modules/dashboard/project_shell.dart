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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Margin.medium),
                    child: Column(
                      children: [
                        _buildTile(
                          context: context,
                          iconData: Icons.checklist,
                          selected: isStartsWith('tasks'),
                          label: 'Tasks',
                          onTap: () {
                            TasksRoute(projectId: projectId).go(context);
                          },
                        ),
                        _buildTile(
                          context: context,
                          selected: isStartsWith('user'),
                          iconData: Icons.people_alt_outlined,
                          label: 'Users',
                          onTap: () {
                            UsersRoute(projectId: projectId).go(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (false)
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

  Widget _buildTile({
    required BuildContext context,
    required String label,
    required IconData iconData,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Margin.xSmall),
      child: ListTile(
        dense: true,
        horizontalTitleGap: 6,
        leading: Icon(iconData, size: 18),
        selected: selected,
        selectedTileColor: context.cs.surfaceContainer,
        selectedColor: context.cs.onSurface,
        minVerticalPadding: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selected
                ? context.cs.surfaceContainerHighest
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(Margin.medium),
        ),
        onTap: onTap,
        visualDensity: const VisualDensity(vertical: -4),
        title: Text(label),
      ),
    );
  }
}

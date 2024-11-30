import '../../utils/common.dart';
import '../project_bar/project_bar_view.dart';
import '../sidebar/sidebar_view.dart';

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
    return Material(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarView(projectId: projectId),
          Expanded(
            child: Column(
              children: [
                ProjectBarView(projectId: projectId),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

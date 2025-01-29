import 'package:scroll_animator/scroll_animator.dart';

import '../../providers/projects_provider.dart';
import '../../utils/common.dart';
import 'projects_view.dart';
import 'widget/create_project_dialog.dart';

class ProjectsState extends CoraConsumerState<ProjectsView> with ObsStateMixin {
  final scrollController = AnimatedScrollController(
    animationFactory: const ChromiumEaseInOut(),
  );

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> createProject(CreateProjectDialogResult result) async {
    final (err, data) = await ref.api.createProject(
      body: {
        'name': result.name,
        'description': result.description,
      },
      cancelToken: cancelToken(),
    ).go();

    if (err != null) return AppSnackbar.error(err);

    ref.invalidate(projectsProvider);
  }
}

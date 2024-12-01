import 'package:scroll_animator/scroll_animator.dart';

import '../../services/api/models/tasks_response.dart';
import '../../utils/app_snackbar.dart';
import '../../utils/common.dart';
import 'tasks_view.dart';

class TasksState extends CoraConsumerState<TasksView> with ObsStateMixin {
  final scrollController = AnimatedScrollController(
    animationFactory: const ChromiumEaseInOut(),
  );

  @override
  void initState() {
    super.initState();
    _getTasks();
    onDispose(scrollController.dispose);
  }

  late final tasks = obs<List<TaskModel>>([]);

  Future<void> _getTasks() async {
    final (err, data) = await ref.api
        .tasks(
          projectId: widget.projectId,
          cancelToken: cancelToken(),
        )
        .go();
    if (err != null) return AppSnackbar.error(err);

    tasks.value = data?.data ?? [];
  }
}

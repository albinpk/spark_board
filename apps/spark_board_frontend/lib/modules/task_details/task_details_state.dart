import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import 'task_details_view.dart';

class TaskDetailsState extends CoraConsumerState<TaskDetailsView>
    with SingleTickerProviderStateMixin, ObsStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
    _getTask();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  late final task = obs<TaskDetails?>(null);

  Future<void> _getTask() async {
    final (err, data) = await ref.api
        .taskDetails(
          projectId: widget.projectId,
          taskId: widget.taskId,
          cancelToken: cancelToken(),
        )
        .go();
    if (err != null) return AppSnackbar.error(err);

    task.value = data!.data;
  }
}

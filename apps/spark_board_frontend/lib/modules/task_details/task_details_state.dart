import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import 'task_details_view.dart';

class TaskDetailsState extends CoraConsumerState<TaskDetailsView>
    with SingleTickerProviderStateMixin, ObsStateMixin {
  final nameController = TextEditingController();
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
    nameController.dispose();
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
    nameController.text = task.value!.name;
  }

  late final isNameEditing = obs(false);

  void onTapNameField() => isNameEditing.setTrue();

  void onNameEditCancel() {
    nameController.text = task.value!.name;
    isNameEditing.setFalse();
  }

  Future<void> onNameSave() async {
    if (nameController.text.trim() == task.value!.name) {
      return isNameEditing.setFalse();
    }

    final (err, data) = await ref.api.updateTask(
      projectId: widget.projectId,
      taskId: widget.taskId,
      body: {
        'name': nameController.text.trim().replaceAll('\n', ' '),
      },
    ).go();

    isNameEditing.setFalse();

    if (err != null) {
      nameController.text = task.value!.name;
      return AppSnackbar.error(err);
    }

    task.value = data!.data;
    nameController.text = task.value!.name;
  }
}

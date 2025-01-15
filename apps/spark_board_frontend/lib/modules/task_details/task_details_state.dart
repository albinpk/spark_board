import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import '../tasks/enums/task_status.dart';
import 'task_details_view.dart';

class TaskDetailsState extends CoraConsumerState<TaskDetailsView>
    with SingleTickerProviderStateMixin, ObsStateMixin {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final scrollController = ScrollController();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
    scrollController.addListener(_onScroll);
    _getTask();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  late final task = obs<TaskDetails?>(null);

  // TODO(albin): fix: desc update with null

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
    descriptionController.text = task.value!.description ?? '';
  }

  /// Visibility of the task name on the header.
  /// Will be true when the scroll offset is greater than 70.
  late final showHeader = obs(false);

  void _onScroll() => showHeader.value = scrollController.offset > 70;

  Future<void> changeStatus(TaskStatus status) async {
    if (task.value!.status == status) return;
    final (err, data) = await ref.api.updateTask(
      projectId: widget.projectId,
      taskId: widget.taskId,
      body: {'status': status.name},
    ).go();
    if (err != null) return AppSnackbar.error(err);
    task.value = data!.data;
  }

  late final isNameEditing = obs(false);

  void onTapNameField() => isNameEditing.setTrue();

  void onNameEditCancel() {
    nameController.text = task.value!.name;
    isNameEditing.setFalse();
  }

  Future<void> onNameSave() async {
    if (nameController.text.trim() == task.value!.name) {
      nameController.text = task.value!.name;
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

  late final isDescriptionEditing = obs(false);

  void onEditDescription() => isDescriptionEditing.setTrue();

  void onDescriptionEditCancel() {
    descriptionController.text = task.value!.description ?? '';
    isDescriptionEditing.setFalse();
  }

  Future<void> onDescriptionSave() async {
    final description = descriptionController.text.trim();
    if (description == (task.value!.description ?? '')) {
      descriptionController.text = task.value!.description ?? '';
      return isDescriptionEditing.setFalse();
    }

    final (err, data) = await ref.api.updateTask(
      projectId: widget.projectId,
      taskId: widget.taskId,
      body: {
        'description': description.isEmpty ? null : description,
      },
    ).go();

    isDescriptionEditing.setFalse();

    if (err != null) {
      descriptionController.text = task.value!.description ?? '';
      return AppSnackbar.error(err);
    }

    task.value = data!.data;
    descriptionController.text = task.value!.description ?? '';
  }
}

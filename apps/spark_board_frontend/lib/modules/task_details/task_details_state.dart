import '../../providers/task_comment_list_provider.dart';
import '../../services/api/models/staffs_response.dart';
import '../../services/api/models/task_comments_response.dart';
import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import '../tasks/enums/task_status.dart';
import 'task_details_view.dart';

class TaskDetailsState extends CoraConsumerState<TaskDetailsView>
    with SingleTickerProviderStateMixin, ObsStateMixin {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final commentController = TextEditingController();
  final scrollController = ScrollController();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration.zero,
    );
    scrollController.addListener(_onScroll);
    _getTask();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    commentController.dispose();
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

    task.value = data?.data;
    nameController.text = task.value?.name ?? '';
    descriptionController.text = task.value?.description ?? '';
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

  Future<void> changeAssignee(StaffResponse staff) async {
    if (task.value!.assignee?.staffId == staff.staffId) return;
    final (err, data) = await ref.api.taskAssign(
      projectId: widget.projectId,
      taskId: task.value!.taskId,
      body: {'staffId': staff.staffId},
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

  Future<void> addComment() async {
    final comment = commentController.text.trim();
    if (comment.isEmpty) return;
    final (err, data) = await ref.api.createTaskComment(
      projectId: widget.projectId,
      taskId: widget.taskId,
      body: {'comment': comment},
    ).go();
    if (err != null) return AppSnackbar.error(err);
    commentController.clear();
    ref.invalidate(taskCommentListProvider);
  }

  Future<void> deleteComment(CommentData comment) async {
    final (err, data) = await ref.api
        .deleteTaskComment(
          projectId: widget.projectId,
          taskId: widget.taskId,
          commentId: comment.commentId,
        )
        .go();
    if (err != null) return AppSnackbar.error(err);
    ref.invalidate(taskCommentListProvider);
  }
}

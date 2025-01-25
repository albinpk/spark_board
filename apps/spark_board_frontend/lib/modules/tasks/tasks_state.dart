import 'package:scroll_animator/scroll_animator.dart';

import '../../services/api/models/staffs_response.dart';
import '../../services/api/models/task_details_response.dart';
import '../../services/api/models/tasks_response.dart';
import '../../utils/common.dart';
import 'enums/task_status.dart';
import 'models/task_model.dart';
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

  @override
  void didUpdateWidget(covariant TasksView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.projectId != oldWidget.projectId) {
      for (final list in tasks.values) {
        list.clear();
      }
      _getTasks();
    }
  }

  final tasks = <TaskStatus, List<TaskBase>>{
    TaskStatus.todo: [],
    TaskStatus.inProgress: [],
    TaskStatus.done: [],
  };

  late final isLoading = obs(false);

  Future<void> _getTasks() async {
    isLoading.setTrue();
    final (err, data) = await ref.api
        .tasks(
          projectId: widget.projectId,
          cancelToken: cancelToken(),
        )
        .go();
    if (mounted) isLoading.setFalse();
    if (err != null) return AppSnackbar.error(err);

    for (final task in data?.data ?? <TaskResponse>[]) {
      tasks.update(
        TaskStatus.fromName(task.status),
        (list) => list..add(TaskModel.fromData(task)),
      );
    }
    if (mounted) setState(() {});
  }

  void onTapAdd(TaskStatus status) {
    if (tasks[status]!.elementAtOrNull(0) is TaskNew) return;
    setState(() {
      tasks[status]!.insert(0, TaskNew(status: status));
    });
  }

  void onRemoveNewCard(TaskStatus status) {
    setState(() => tasks[status]!.removeAt(0));
  }

  Future<void> createNewTask({
    required TaskStatus status,
    required String name,
  }) async {
    final (err, data) = await ref.api.createTask(
      projectId: widget.projectId,
      body: {
        'name': name,
        'status': status.name,
      },
    ).go();
    if (err != null) return AppSnackbar.error(err);

    setState(() {
      tasks[status]![0] = TaskModel.fromData(data!.data);
    });
  }

  Future<void> deleteTask(TaskModel task) async {
    final (err, data) = await ref.api
        .deleteTask(
          projectId: widget.projectId,
          taskId: task.taskId,
        )
        .go();
    if (err != null) return AppSnackbar.error(err);

    setState(() {
      tasks[task.status]!.remove(task);
    });
  }

  Future<void> changeStatus(TaskModel task, TaskStatus status) async {
    if (task.status == status) return;

    final (err, data) = await ref.api.updateTask(
      projectId: widget.projectId,
      taskId: task.taskId,
      body: {
        'status': status.name,
      },
    ).go();
    if (err != null) return AppSnackbar.error(err);

    setState(() {
      tasks[task.status]!.remove(task);
      tasks[status]!.add(TaskModel.fromDetails(data!.data));
    });
  }

  Future<void> changeAssignee(TaskModel task, StaffResponse staff) async {
    if (task.assignee?.staffId == staff.staffId) return;

    final (err, data) = await ref.api.taskAssign(
      projectId: widget.projectId,
      taskId: task.taskId,
      body: {
        'staffId': staff.staffId,
      },
    ).go();
    if (err != null) return AppSnackbar.error(err);

    setState(() {
      tasks[task.status]![tasks[task.status]!.indexOf(task)] =
          TaskModel.fromDetails(data!.data);
    });
  }

  static TasksState of(BuildContext context) {
    return TaskStateProvider.of(context).state;
  }

  void replaceTask(TaskDetails taskDetails) {
    final task = TaskModel.fromDetails(taskDetails);

    TaskStatus? prevStatus;
    int? index;
    for (final MapEntry(:key, :value) in tasks.entries) {
      final i = value.indexWhere((e) {
        return e is TaskModel && e.taskId == task.taskId;
      });
      if (i != -1) {
        prevStatus = key;
        index = i;
        break;
      }
    }
    if (prevStatus == null || index == null) return;

    setState(() {
      if (task.status == prevStatus) {
        tasks[prevStatus]![index!] = task;
      } else {
        tasks[prevStatus]!.removeAt(index!);
        tasks[task.status]!.add(task);
      }
    });
  }
}

class TaskStateProvider extends InheritedWidget {
  const TaskStateProvider({
    required this.state,
    required super.child,
    super.key,
  });

  final TasksState state;

  @override
  bool updateShouldNotify(covariant TaskStateProvider oldWidget) {
    return false;
  }

  static TaskStateProvider of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<TaskStateProvider>()!;
  }
}

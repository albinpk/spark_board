import 'package:scroll_animator/scroll_animator.dart';

import '../../services/api/models/staffs_response.dart';
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
    _getStaffs();
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

  Future<void> _getTasks() async {
    final (err, data) = await ref.api
        .tasks(
          projectId: widget.projectId,
          cancelToken: cancelToken(),
        )
        .go();
    if (err != null) return AppSnackbar.error(err);

    for (final task in data?.data ?? <TaskResponse>[]) {
      tasks.update(
        TaskStatus.fromName(task.status),
        (list) => list..add(TaskModel.fromData(task)),
      );
    }
    setState(() {});
  }

  List<StaffResponse> staffs = [];

  Future<void> _getStaffs() async {
    final (err, data) = await ref.api.staffs(cancelToken: cancelToken()).go();
    if (err != null) return AppSnackbar.error(err);
    staffs = data!.data;
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
      tasks[status]!.add(TaskModel.fromData(data!.data));
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
          TaskModel.fromData(data!.data);
    });
  }

  static TasksState of(BuildContext context) {
    return TaskStateProvider.of(context).state;
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

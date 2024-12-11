import '../../../services/api/models/tasks_response.dart';
import '../enums/task_status.dart';

sealed class TaskBase {
  const TaskBase({
    required this.status,
  });

  final TaskStatus status;
}

class TaskModel extends TaskBase {
  const TaskModel({
    required this.taskId,
    required this.name,
    required this.description,
    required super.status,
    required this.createdAt,
    required this.assignee,
  });

  factory TaskModel.fromData(TaskResponse task) {
    return TaskModel(
      taskId: task.taskId,
      name: task.name,
      description: task.description,
      status: TaskStatus.fromName(task.status),
      createdAt: DateTime.parse(task.createdAt),
      assignee: task.assignee,
    );
  }

  final String taskId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final Assignee? assignee;
}

class TaskNew extends TaskBase {
  const TaskNew({required super.status});
}

/// Tasks list api response.
class TasksResponse {
  const TasksResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TasksResponse.fromJson(Map<String, dynamic> json) {
    return TasksResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final bool status;
  final String message;
  final List<TaskModel> data;
}

class TaskModel {
  const TaskModel({
    required this.taskId,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  final String taskId;
  final String name;
  final String description;
  final String createdAt;
}

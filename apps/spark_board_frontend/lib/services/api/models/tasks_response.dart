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
          .map((e) => TaskResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final bool status;
  final String message;
  final List<TaskResponse> data;
}

class TaskResponse {
  const TaskResponse({
    required this.taskId,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    this.assignee,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      taskId: json['task_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      assignee: json['assignee'] == null
          ? null
          : Assignee.fromJson(json['assignee'] as Map<String, dynamic>),
    );
  }

  final String taskId;
  final String name;
  final String? description;
  final String status;
  final String createdAt;
  final Assignee? assignee;
}

class Assignee {
  const Assignee({
    required this.staffId,
    required this.name,
    required this.email,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) {
    return Assignee(
      staffId: json['staff_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  final String staffId;
  final String name;
  final String email;
}

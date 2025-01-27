import '../../../modules/tasks/enums/task_status.dart';
import 'tasks_response.dart';

class TaskDetailsResponse {
  const TaskDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TaskDetailsResponse.fromJson(Map<String, dynamic> json) {
    return TaskDetailsResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: TaskDetails.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final bool status;
  final String message;
  final TaskDetails data;

  @override
  String toString() =>
      'TaskDetailsResponse(status: $status,message: $message,data: $data)';
}

class TaskDetails {
  const TaskDetails({
    required this.taskId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.project,
    required this.totalComments,
    this.description,
    this.assignee,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      taskId: json['task_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      status: TaskStatus.fromName(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      totalComments: json['total_comments'] as int,
      assignee: json['assignee'] == null
          ? null
          : Assignee.fromJson(json['assignee'] as Map<String, dynamic>),
      project: Project.fromJson(json['project'] as Map<String, dynamic>),
    );
  }

  final String taskId;
  final String name;
  final String? description;
  final TaskStatus status;
  final DateTime createdAt;
  final Assignee? assignee;
  final Project project;
  final int totalComments;

  @override
  String toString() =>
      'Data(taskId: $taskId,name: $name,description: $description,status: $status,createdAt: $createdAt,assignee: $assignee,project: $project)';
}

class Project {
  const Project({
    required this.projectId,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'] as String,
      ownerId: json['owner_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final String projectId;
  final String ownerId;
  final String name;
  final String? description;
  final DateTime createdAt;

  @override
  String toString() =>
      'Project(projectId: $projectId,ownerId: $ownerId,name: $name,description: $description,createdAt: $createdAt)';
}

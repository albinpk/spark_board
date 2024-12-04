import 'tasks_response.dart';

class CreateTaskResponse {
  const CreateTaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateTaskResponse.fromJson(Map<String, dynamic> json) {
    return CreateTaskResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: TaskResponse.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final bool status;
  final String message;
  final TaskResponse data;
}

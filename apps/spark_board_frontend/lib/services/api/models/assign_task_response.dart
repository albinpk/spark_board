import 'task_details_response.dart';

/// Assign/Unassign task api response.
class AssignTaskResponse {
  const AssignTaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignTaskResponse.fromJson(Map<String, dynamic> json) {
    return AssignTaskResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: TaskDetails.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final bool status;
  final String message;
  final TaskDetails data;
}

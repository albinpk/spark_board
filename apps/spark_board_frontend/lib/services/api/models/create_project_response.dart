class CreateProjectResponse {
  const CreateProjectResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateProjectResponse.fromJson(Map<String, dynamic> json) {
    return CreateProjectResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final bool status;
  final String message;
  final Data data;

  @override
  String toString() =>
      'CreateProjectResponse(status: $status,message: $message,data: $data)';
}

class Data {
  const Data({
    required this.projectId,
    required this.name,
    required this.createdAt,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      projectId: json['project_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final String projectId;
  final String name;
  final String? description;
  final DateTime createdAt;

  @override
  String toString() =>
      'Data(projectId: $projectId,name: $name,description: $description,createdAt: $createdAt)';
}

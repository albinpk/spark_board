/// Projects list api response.
class ProjectsResponse {
  const ProjectsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final bool status;
  final String message;
  final List<Data> data;
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
}

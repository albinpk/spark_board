/// Staff list api response.
class StaffsResponse {
  const StaffsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StaffsResponse.fromJson(Map<String, dynamic> json) {
    return StaffsResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => StaffResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final bool status;
  final String message;
  final List<StaffResponse> data;
}

class StaffResponse {
  const StaffResponse({
    required this.staffId,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory StaffResponse.fromJson(Map<String, dynamic> json) {
    return StaffResponse(
      staffId: json['staff_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  final String staffId;
  final String name;
  final String email;
  final String createdAt;
}

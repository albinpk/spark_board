import 'staffs_response.dart';

/// Create staff api response
class CreateStaffResponse {
  const CreateStaffResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateStaffResponse.fromJson(Map<String, dynamic> json) {
    return CreateStaffResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: StaffResponse.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final bool status;
  final String message;
  final StaffResponse data;
}

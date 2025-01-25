class CreateTaskCommentResponse {
  const CreateTaskCommentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateTaskCommentResponse.fromJson(Map<String, dynamic> json) {
    return CreateTaskCommentResponse(
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
      'CreateTaskCommentResponse(status: $status,message: $message,data: $data)';
}

class Data {
  const Data({
    required this.commentId,
    required this.comment,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      commentId: json['comment_id'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
    );
  }

  final String commentId;
  final String comment;
  final DateTime createdAt;

  @override
  String toString() =>
      'Data(commentId: $commentId,comment: $comment,createdAt: $createdAt)';
}

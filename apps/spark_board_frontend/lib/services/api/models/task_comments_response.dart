class TaskCommentsResponse {
  const TaskCommentsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TaskCommentsResponse.fromJson(Map<String, dynamic> json) {
    return TaskCommentsResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final bool status;
  final String message;
  final List<CommentData> data;

  @override
  String toString() =>
      'TaskCommentsResponse(status: $status,message: $message,data: $data)';
}

class CommentData {
  const CommentData({
    required this.commentId,
    required this.comment,
    required this.createdAt,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
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

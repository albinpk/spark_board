import '../services/api/models/task_comments_response.dart';
import '../utils/common.dart';

part 'task_comment_list_provider.g.dart';

@riverpod
Future<List<CommentData>> taskCommentList(
  Ref ref, {
  required String projectId,
  required String taskId,
}) async {
  final res = await ref.api.getTaskComments(
    projectId: projectId,
    taskId: taskId,
    cancelToken: ref.cancelToken(),
  );
  return res.data.data;
}

import '../services/api/models/projects_response.dart';
import '../utils/common.dart';

part 'projects_provider.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  FutureOr<List<Data>> build() async {
    final response = await ref.api.projects(
      cancelToken: ref.cancelToken(),
    );
    return response.data.data;
  }
}

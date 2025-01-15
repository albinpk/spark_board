import '../services/api/models/staffs_response.dart';
import '../utils/common.dart';

part 'staff_list_provider.g.dart';

/// Cached staff list provider.
@riverpod
FutureOr<List<StaffResponse>> staffList(Ref ref) async {
  final res = await ref.api.staffs(cancelToken: ref.cancelToken());
  ref.keepAlive();
  return res.data.data;
}

import 'dart:async';

import '../../services/api/models/staffs_response.dart';
import '../../utils/common.dart';
import 'staff_view.dart';

class StaffState extends CoraConsumerState<StaffView> with ObsStateMixin {
  @override
  void initState() {
    super.initState();
    _getStaffs();
  }

  late final staffs = obs<List<StaffResponse>>([]);

  Future<void> _getStaffs() async {
    final (err, data) = await ref.api.staffs(cancelToken: cancelToken()).go();
    if (err != null) return AppSnackbar.error(err);

    staffs.value = data!.data;
  }

  Future<void> updateName(StaffResponse staff, String name) async {
    final (err, data) = await ref.api.updateStaff(
      staffId: staff.staffId,
      body: {
        'name': name.trim(),
      },
    ).go();

    if (err != null) return AppSnackbar.error(err);

    staffs[staffs.indexOf(staff)] = data!.data;
    staffs.refresh();
  }
}

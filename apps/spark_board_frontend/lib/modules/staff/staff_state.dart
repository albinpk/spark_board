import 'dart:async';

import '../../providers/staff_list_provider.dart';
import '../../services/api/models/staffs_response.dart';
import '../../utils/common.dart';
import 'staff_view.dart';
import 'widgets/create_staff_dialog.dart';

class StaffState extends CoraConsumerState<StaffView> with ObsStateMixin {
  Future<void> updateName(StaffResponse staff, String name) async {
    if (staff.name == name) return;
    final (err, data) = await ref.api.updateStaff(
      staffId: staff.staffId,
      body: {'name': name},
    ).go();
    if (err != null) return AppSnackbar.error(err);
    ref.invalidate(staffListProvider);
  }

  Future<void> deleteStaff(StaffResponse staff) async {
    final (err, data) = await ref.api
        .deleteStaff(
          staffId: staff.staffId,
        )
        .go();
    if (err != null) return AppSnackbar.error(err);
    ref.invalidate(staffListProvider);
  }

  Future<void> createStaff(CreateStaffDialogResult result) async {
    final (err, data) = await ref.api.createStaff(
      body: {
        'name': result.name,
        'email': result.email,
      },
    ).go();
    if (err != null) return AppSnackbar.error(err);
    ref.invalidate(staffListProvider);
  }
}

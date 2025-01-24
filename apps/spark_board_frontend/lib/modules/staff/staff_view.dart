import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../providers/staff_list_provider.dart';
import '../../services/api/models/staffs_response.dart';
import '../../utils/common.dart';
import 'staff_state.dart';
import 'widgets/create_staff_dialog.dart';

/// Route: [StaffRoute].
class StaffView extends CoraConsumerView<StaffState> {
  const StaffView({super.key});

  @override
  StaffState createState() => StaffState();

  @override
  Widget build(BuildContext context, StaffState state) {
    // for skeletonizer
    final mock = StaffResponse(
      staffId: '1',
      name: BoneMock.fullName,
      email: BoneMock.email,
      createdAt: BoneMock.date,
    );

    final asyncValue = state.watch(staffListProvider);
    final staffs = asyncValue.valueOrNull ?? [mock, mock, mock];

    return WebTitle(
      title: 'Staff',
      child: Padding(
        padding: const EdgeInsets.all(Margin.xxLarge),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Staffs',
                    style: context.titleLarge,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _onTapCreateStaff(state),
                  icon: const Icon(Icons.add),
                  label: const Text('Add staff'),
                ),
              ],
            ),
            H.large,
            Expanded(
              child: asyncValue.hasError
                  ? Text(asyncValue.error.toString())
                  : Skeletonizer(
                      enabled: asyncValue.isLoading,
                      child: TableView.builder(
                        columnCount: 4,
                        rowCount: staffs.length + 1, // +1 for header
                        pinnedRowCount: 1, // header
                        columnBuilder: (i) => _columnBuilder(context, i),
                        rowBuilder: (i) => _rowBuilder(context, i),
                        cellBuilder: (context, vicinity) =>
                            _cellBuilder(context, vicinity, state, staffs),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapCreateStaff(StaffState state) async {
    final result = await showDialog<CreateStaffDialogResult>(
      context: state.context,
      builder: (context) {
        return const Dialog(
          child: CreateStaffDialog(),
        );
      },
    );
    if (result == null) return;
    await state.createStaff(result);
  }

  Future<void> _onEdit(StaffResponse staff, StaffState state) async {
    final result = await showDialog<CreateStaffDialogResult>(
      context: state.context,
      builder: (context) {
        return Dialog(
          child: CreateStaffDialog(staff: staff),
        );
      },
    );
    if (result == null) return;
    await state.updateName(staff, result.name);
  }

  TableSpan _columnBuilder(BuildContext context, int index) {
    return TableSpan(
      padding: const SpanPadding.all(Margin.medium),
      extent: switch (index) {
        0 => const FixedSpanExtent(50),
        1 => const FixedSpanExtent(150),
        2 => const FixedSpanExtent(200),
        3 => const FixedSpanExtent(150),
        _ => throw UnimplementedError(),
      },
    );
  }

  TableSpan _rowBuilder(BuildContext context, int index) {
    return TableSpan(
      backgroundDecoration: SpanDecoration(
        color: index.isOdd ? context.cs.surfaceContainerLow : null,
      ),
      extent: const FixedSpanExtent(35),
    );
  }

  TableViewCell _cellBuilder(
    BuildContext context,
    TableVicinity vicinity,
    StaffState state,
    List<StaffResponse> staffs,
  ) {
    if (vicinity.row == 0) {
      // header
      final style = context.bodySmall.copyWith(
        fontWeight: FontWeight.w600,
      );
      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: switch (vicinity.column) {
            0 => Text('No.', style: style),
            1 => Text('Name', style: style),
            2 => Text('Email', style: style),
            3 => const SizedBox.shrink(),
            _ => throw UnimplementedError(),
          },
        ),
      );
    }

    final staff = staffs[vicinity.row - 1];

    return TableViewCell(
      child: Align(
        alignment: Alignment.centerLeft,
        child: switch (vicinity.column) {
          0 => Text('${vicinity.row}'),
          1 => Text(staff.name),
          2 => Text(staff.email),
          3 => _buildActions(state, staff),
          _ => throw UnimplementedError(),
        },
      ),
    );
  }

  Widget _buildActions(StaffState state, StaffResponse staff) {
    return Row(
      children: [
        // edit
        IconButton(
          tooltip: 'Edit',
          icon: const Icon(Icons.edit),
          iconSize: 18,
          color: state.context.cs.onSurface.fade(0.5),
          onPressed: () => _onEdit(staff, state),
        ),

        // delete
        IconButton(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return state.context.cs.error;
              }
              return null;
            }),
          ),
          tooltip: 'Delete',
          icon: const Icon(Icons.delete),
          iconSize: 18,
          color: state.context.cs.onSurface.fade(0.5),
          onPressed: () => _onDelete(staff, state),
        ),
      ],
    );
  }

  Future<void> _onDelete(StaffResponse staff, StaffState state) async {
    final confirmed = await confirmDialog(
      context: state.context,
      description: 'Are you sure you want to delete this staff?',
      confirmText: 'Yes, Delete',
    );
    if (!confirmed) return;
    await state.deleteStaff(staff);
  }
}

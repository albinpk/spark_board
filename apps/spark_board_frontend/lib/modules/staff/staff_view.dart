import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../utils/common.dart';
import 'staff_state.dart';
import 'widgets/input_cell.dart';

/// Route: [StaffRoute].
class StaffView extends CoraConsumerView<StaffState> {
  const StaffView({super.key});

  @override
  StaffState createState() => StaffState();

  @override
  Widget build(BuildContext context, StaffState state) {
    return TableView.builder(
      columnCount: 3,
      rowCount: state.staffs.length + 1, // +1 for header
      columnBuilder: (i) => _columnBuilder(context, i),
      rowBuilder: (i) => _rowBuilder(context, i),
      cellBuilder: (context, vicinity) =>
          _cellBuilder(context, vicinity, state),
    );
  }

  TableSpan _columnBuilder(BuildContext context, int index) {
    return TableSpan(
      padding: const SpanPadding.all(Margin.medium),
      extent: switch (index) {
        0 => const FixedSpanExtent(50),
        1 => const FixedSpanExtent(150),
        2 => const RemainingSpanExtent(),
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
            _ => throw UnimplementedError(),
          },
        ),
      );
    }

    final staff = state.staffs[vicinity.row - 1];

    return TableViewCell(
      child: Align(
        alignment: Alignment.centerLeft,
        child: switch (vicinity.column) {
          0 => Text('${vicinity.row}'),
          1 => InputCell(
              value: staff.name,
              style: context.bodyMedium,
              onChanged: (name) {
                state.updateName(staff, name);
              },
            ),
          2 => Text(staff.email),
          _ => throw UnimplementedError(),
        },
      ),
    );
  }
}

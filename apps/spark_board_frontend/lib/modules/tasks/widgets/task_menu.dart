import '../../../utils/common.dart';
import '../models/task_model.dart';
import '../tasks_state.dart';

/// Widget that displays when the more
/// button is tapped on a task card.
class TaskMenu extends StatelessWidget {
  const TaskMenu({
    required this.task,
    super.key,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.cs.surfaceContainerHigh,
      elevation: 2,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildItem(
              context: context,
              label: 'Delete',
              onTap: () {
                TasksState.of(context).deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Margin.medium,
          vertical: Margin.xSmall,
        ).copyWith(right: Margin.xxLarge),
        child: Text(
          label,
          style: context.labelMedium,
        ),
      ),
    );
  }
}

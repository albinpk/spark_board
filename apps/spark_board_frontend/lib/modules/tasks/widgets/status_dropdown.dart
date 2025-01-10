import '../../../utils/common.dart';
import '../enums/task_status.dart';
import '../models/task_model.dart';
import '../tasks_state.dart';

class StatusDropdown extends StatelessWidget {
  const StatusDropdown({
    required this.task,
    super.key,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.cs.onSurface.withOpacity(0.1),
        ),
      ),
      child: Drop(
        dropBuilder: (context, controller) {
          return DropChild(
            children: [
              for (final status in TaskStatus.values)
                DropItem(
                  label: status.label,
                  onTap: () {
                    controller.hide();
                    TasksState.of(context).changeStatus(task, status);
                  },
                ),
            ],
          );
        },
        childBuilder: (context, controller) {
          return LimitedBox(
            maxWidth: 60,
            child: InkWell(
              onTap: controller.show,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        task.status.label,
                        style: context.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: context.cs.onSurface.withOpacity(0.7),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

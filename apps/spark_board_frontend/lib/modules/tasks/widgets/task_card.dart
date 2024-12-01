import '../../../services/api/models/tasks_response.dart';
import '../../../utils/common.dart';
import '../enums/task_status.dart';

/// A widget that displays a task card in the tasks view.
class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.status,
    required this.task,
    super.key,
  });

  final TaskModel task;
  final TaskStatus status;

  static const width = 140.0;
  static const height = 80.0;

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
      width: 0.3,
      color: status.color,
    );
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: context.cs.surfaceContainer,
        shape: Border(
          left: BorderSide(
            width: 2,
            color: status.color,
          ),
          top: border,
          right: border,
          bottom: border,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Margin.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  task.name,
                  style: context.bodySmall,
                  overflow: TextOverflow.fade,
                ),
              ),
              H.small,
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.cs.onSurface.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        'Albin',
                        style: context.labelSmall,
                      ),
                    ),
                  ),
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.cs.onSurface.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        status.name.capitalize,
                        style: context.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

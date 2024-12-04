import 'package:flutter/services.dart';

import '../../../utils/common.dart';
import '../models/task_model.dart';
import '../tasks_state.dart';

/// A widget that displays a task card in the tasks view.
class TaskCard extends StatefulWidget {
  const TaskCard({
    required this.task,
    super.key,
  });

  final TaskBase task;

  static const width = 140.0;
  static const height = 80.0;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late final _inputFocusNode = FocusNode()..addListener(() => setState(() {}));

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _inputFocusNode.hasFocus;
    final task = widget.task;
    final border = BorderSide(
      width: 2,
      color: task.status.color,
    );
    final thinBorder = BorderSide(
      width: 0.3,
      color: task.status.color,
    );
    return SizedBox(
      height: TaskCard.height,
      width: TaskCard.width,
      child: Focus(
        onKeyEvent: (node, event) {
          if (task is TaskNew &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            TasksState.of(context).onRemoveNewCard(task.status);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: context.cs.surfaceContainer,
          shape: Border(
            left: border,
            top: focused ? border : thinBorder,
            right: focused ? border : thinBorder,
            bottom: focused ? border : thinBorder,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Margin.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: switch (task) {
                    TaskModel() => Text(
                        task.name,
                        style: context.bodySmall,
                        overflow: TextOverflow.fade,
                      ),
                    TaskNew() => _buildInputField(context),
                  },
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
                          task.status.name.capitalize,
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
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return TextFormField(
      expands: true,
      maxLines: null,
      style: context.labelSmall,
      focusNode: _inputFocusNode,
      autofocus: true,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter task name...',
        hintStyle: TextStyle(
          color: context.cs.onSurface.withOpacity(0.3),
        ),
      ),
      onChanged: (value) {
        value = value.trimLeft();
        if (!value.contains('\n')) return;
        TasksState.of(context).createNewTask(
          status: widget.task.status,
          name: value.trim(),
        );
      },
    );
  }
}

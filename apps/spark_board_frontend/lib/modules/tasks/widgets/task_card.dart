import 'package:flutter/services.dart';

import '../../../utils/common.dart';
import '../models/task_model.dart';
import '../tasks_state.dart';
import 'assign_dropdown.dart';
import 'status_dropdown.dart';

/// A widget that displays a task card in the tasks view.
class TaskCard extends StatefulWidget {
  const TaskCard({
    required this.task,
    super.key,
  });

  final TaskBase task;

  static const width = 160.0;
  static const height = 90.0;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late final _inputFocusNode = FocusNode()..addListener(() => setState(() {}));

  final _overlayController = OverlayPortalController();

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  bool _showMoreButton = false;

  @override
  Widget build(BuildContext context) {
    final focused = _inputFocusNode.hasFocus;
    final task = widget.task;
    final border = BorderSide(
      width: 2,
      color: task.status.color,
    );
    final thinBorder = BorderSide(
      color: task.status.color,
    );
    return SizedBox(
      height: TaskCard.height,
      width: TaskCard.width,
      child: MouseRegion(
        onEnter: (event) {
          setState(() => _showMoreButton = true);
        },
        onExit: (event) {
          setState(() => _showMoreButton = false);
        },
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
            child: Stack(
              children: [
                Padding(
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

                      // assignee and status
                      if (task is TaskModel)
                        Row(
                          children: [
                            AssignDropdown(task: task),
                            const Spacer(),
                            StatusDropdown(task: task),
                          ],
                        ),
                    ],
                  ),
                ),

                // more button
                if (task is TaskModel)
                  _buildMoreButton(
                    task,
                    _showMoreButton || _overlayController.isShowing,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton(TaskModel task, bool showBorder) {
    return Align(
      alignment: Alignment.topRight,
      child: Drop(
        controller: _overlayController,
        childBuilder: (context, controller) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(
                color: showBorder
                    ? context.cs.onSurface.withOpacity(0.5)
                    : Colors.transparent,
              ),
            ),
            child: InkWell(
              onTap: controller.show,
              child: const Padding(
                padding: EdgeInsets.all(Margin.xxSmall),
                child: Icon(
                  Icons.more_vert,
                  size: 12,
                ),
              ),
            ),
          );
        },
        dropBuilder: (context, controller) {
          return DropChild(
            children: [
              DropItem(
                label: 'Delete',
                onTap: () {
                  controller.hide();
                  TasksState.of(context).deleteTask(task);
                },
              ),
            ],
          );
        },
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

import 'package:flutter/services.dart';

import '../../../services/api/models/task_details_response.dart';
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

  static const width = 180.0;
  static const height = 100.0;

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

    final card = SizedBox(
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
            color: context.cs.surfaceContainer,
            shape: Border(
              left: border,
              top: focused ? border : thinBorder,
              right: focused ? border : thinBorder,
              bottom: focused ? border : thinBorder,
            ),
            child: Stack(
              children: [
                // data
                Padding(
                  padding: const EdgeInsets.all(Margin.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: switch (task) {
                          TaskModel() => HoverLinkText(
                              text: task.name,
                              onTap: () => _showTaskDetails(task),
                              style: context.bodyMedium,
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

    if (task is! TaskModel) return card;
    return card;

    return Draggable<TaskModel>(
      data: task,
      feedback: SizedBox(
        child: Card(
          elevation: 0,
          color: context.cs.surfaceContainer,
          shape: Border(
            left: thinBorder.copyWith(width: 2),
            top: thinBorder,
            right: thinBorder,
            bottom: thinBorder,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Margin.medium),
            child: Text(
              task.name,
              style: context.bodySmall,
            ),
          ),
        ),
      ),
      child: card,
    );
  }

  Future<void> _showTaskDetails(TaskModel task) async {
    final updatedTask = await TaskDetailsDialogRoute(
      projectId: GoRouterState.of(context).pathParameters['projectId']!,
      taskId: task.taskId,
    ).push<TaskDetails>(context);
    if (!mounted || updatedTask == null) return;
    TasksState.of(context).replaceTask(updatedTask);
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
                  size: 16,
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
      style: context.bodyMedium,
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

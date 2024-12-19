import 'package:flutter/services.dart';

import '../../../utils/common.dart';
import '../models/task_model.dart';
import '../tasks_state.dart';
import 'assign_dropdown.dart';
import 'status_dropdown.dart';
import 'task_menu.dart';

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

  final _overlayController = OverlayPortalController();
  final _layerLink = LayerLink();

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
      width: 0.5,
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
                if (task is TaskModel &&
                    (_showMoreButton || _overlayController.isShowing))
                  _buildMoreButton(task, thinBorder),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton(TaskModel task, BorderSide thinBorder) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: thinBorder.color,
            width: thinBorder.width,
          ),
        ),
        child: InkWell(
          onTap: _overlayController.show,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: OverlayPortal(
              controller: _overlayController,
              overlayChildBuilder: (context) {
                return CompositedTransformFollower(
                  link: _layerLink,
                  targetAnchor: Alignment.bottomLeft,
                  showWhenUnlinked: false,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TapRegion(
                      onTapOutside: (event) {
                        _overlayController.hide();
                        setState(() {});
                      },
                      child: TaskMenu(task: task),
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(Margin.xxSmall),
                child: Icon(
                  Icons.more_vert,
                  size: 12,
                ),
              ),
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

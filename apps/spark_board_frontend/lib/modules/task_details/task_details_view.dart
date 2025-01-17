import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import '../tasks/enums/task_status.dart';
import '../tasks/models/task_model.dart';
import '../tasks/widgets/assign_dropdown.dart';
import 'task_details_state.dart';

/// Route: [TaskDetailsDialogRoute].
class TaskDetailsView extends CoraConsumerView<TaskDetailsState> {
  const TaskDetailsView({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  @override
  TaskDetailsState createState() => TaskDetailsState();

  static const _namePadding = 6.0;

  @override
  Widget build(BuildContext context, TaskDetailsState state) {
    final task = state.task.value;

    // TODO(albin): add shimmer
    if (task == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Close',
            onPressed: () {
              context.pop<TaskDetails>();
            },
            icon: const Icon(Icons.close),
          ),
          const Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(Margin.small).copyWith(
            left: Margin.xLarge,
          ),
          child: Row(
            children: [
              // task name; only visible when scrolled
              Expanded(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  firstCurve: Curves.easeInOut,
                  secondCurve: Curves.easeInOut,
                  sizeCurve: Curves.easeInOut,
                  crossFadeState: state.showHeader.value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Text(
                    task.name,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall,
                  ),
                  secondChild: const SizedBox(),
                ),
              ),
              W.xxLarge,

              // close button
              CloseButton(
                onPressed: () => context.pop<TaskDetails>(task),
              ),
            ],
          ),
        ),
        Flexible(
          child: NestedScrollView(
            controller: state.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              final labelStyle = context.bodyMedium.copyWith(
                color: context.cs.onSurface.withValues(alpha: 0.7),
              );
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          Margin.xLarge - _namePadding,
                        ),
                        child: _buildTaskName(state, task),
                      ),

                      // status
                      Padding(
                        padding: const EdgeInsets.all(Margin.xLarge),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Status',
                                      style: labelStyle,
                                    ),
                                  ),
                                  W.xxLarge,
                                  Expanded(
                                    child: PopupMenuButton(
                                      tooltip: 'Change status',
                                      menuPadding: EdgeInsets.zero,
                                      position: PopupMenuPosition.under,
                                      initialValue: task.status,
                                      onSelected: state.changeStatus,
                                      itemBuilder: (context) {
                                        return TaskStatus.values
                                            .map(
                                              (e) => PopupMenuItem(
                                                value: e,
                                                height: 35,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox.square(
                                                      dimension: 7,
                                                      child: ClipOval(
                                                        child: ColoredBox(
                                                          color: e.color,
                                                        ),
                                                      ),
                                                    ),
                                                    W.medium,
                                                    Text(e.label),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList();
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox.square(
                                              dimension: 10,
                                              child: ClipOval(
                                                child: ColoredBox(
                                                  color: task.status.color,
                                                ),
                                              ),
                                            ),
                                            W.medium,
                                            Text(
                                              task.status.label,
                                              style: context.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              H.large,

                              // assignee
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Assigned to',
                                      style: labelStyle,
                                    ),
                                  ),
                                  W.xxLarge,
                                  Expanded(
                                    child: SizedBox(
                                      width: 100,
                                      child: AssignDropdown(
                                        task: TaskModel.fromDetails(task),
                                        onAssign: state.changeAssignee,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              H.large,

                              // created at
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Created at',
                                      style: labelStyle,
                                    ),
                                  ),
                                  W.xxLarge,
                                  Expanded(
                                    child: Text(task.createdAt.format()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  controller: state.tabController,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: context.cs.onSurface,
                  labelColor: context.cs.onSurface,
                  tabs: const [
                    Tab(child: Text('Description')),
                    // Tab(child: Text('Comments')),
                  ],
                ),
                Flexible(
                  child: TabBarView(
                    controller: state.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTaskDescription(state, task),
                          ],
                        ),
                      ),
                      // ListView.builder(
                      //   itemBuilder: (context, index) {
                      //     return Text('Comment $index');
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskName(TaskDetailsState state, TaskDetails task) {
    final context = state.context;
    return Column(
      children: [
        TextField(
          controller: state.nameController,
          style: context.titleLarge,
          readOnly: !state.isNameEditing.value,
          onTap: state.onTapNameField,
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter task name...',
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(_namePadding),
            border: MaterialStateOutlineInputBorder.resolveWith((states) {
              return OutlineInputBorder(
                borderSide: state.isNameEditing.value
                    ? const BorderSide()
                    : states.contains(WidgetState.hovered)
                        ? const BorderSide(width: 0.5)
                        : BorderSide.none,
              );
            }),
          ),
        ),

        // cancel & save
        if (state.isNameEditing.value) ...[
          H.small,
          Row(
            children: [
              FilledButton(
                onPressed: state.onNameSave,
                child: const Text('Save'),
              ),
              W.small,
              TextButton(
                onPressed: state.onNameEditCancel,
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTaskDescription(TaskDetailsState state, TaskDetails task) {
    final hasDescription = task.description != null;
    return Padding(
      padding: const EdgeInsets.all(Margin.xLarge),
      child: Column(
        children: [
          if (!state.isDescriptionEditing.value)
            _buildDescriptionView(state, task)
          else
            _buildDescriptionEdit(state, task),

          H.small,
          // save & cancel
          if (state.isDescriptionEditing.value)
            Row(
              children: [
                FilledButton(
                  onPressed: state.onDescriptionSave,
                  child: const Text('Save'),
                ),
                W.small,
                TextButton(
                  onPressed: state.onDescriptionEditCancel,
                  child: const Text('Cancel'),
                ),
              ],
            )

          // edit
          else if (hasDescription)
            Row(
              children: [
                TextButton.icon(
                  onPressed: state.onEditDescription,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDescriptionView(TaskDetailsState state, TaskDetails task) {
    final hasDescription = task.description != null;
    return SizedBox(
      width: double.infinity,
      child: Card.filled(
        child: Padding(
          padding: const EdgeInsets.all(Margin.medium),
          child: !hasDescription
              ? SizedBox(
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'No description added yet.',
                          style: state.context.bodySmall.copyWith(
                            color: state.context.cs.onSurface
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        H.small,
                        TextButton.icon(
                          onPressed: state.onEditDescription,
                          icon: const Icon(Icons.add),
                          label: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(task.description ?? ''),
        ),
      ),
    );
  }

  Widget _buildDescriptionEdit(TaskDetailsState state, TaskDetails task) {
    final context = state.context;
    return TextField(
      controller: state.descriptionController,
      autofocus: true,
      style: context.bodyMedium,
      minLines: 4,
      maxLines: 10,
      decoration: const InputDecoration(
        hintText: 'Enter task description...',
      ),
    );
  }
}

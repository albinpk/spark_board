import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
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
    if (task == null) return const Center(child: CircularProgressIndicator());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(Margin.small),
          child: Row(
            children: [
              // const IconButton(
              //   tooltip: 'Copy link',
              //   onPressed: null,
              //   icon: Icon(Icons.link),
              // ),
              const Spacer(),
              IconButton(
                tooltip: 'Close',
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Flexible(
          child: NestedScrollView(
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
                        padding:
                            const EdgeInsets.all(Margin.xLarge - _namePadding),
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
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Card.filled(
                                        color: task.status.color,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Margin.small,
                                          ),
                                          child: Text(
                                            task.status.label,
                                            style: context.bodyMedium.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
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
                                    child: Text(
                                      task.assignee?.name ?? 'Not assigned',
                                      style: context.bodyMedium.copyWith(
                                        color: task.assignee == null
                                            ? context.cs.onSurface
                                                .withValues(alpha: 0.6)
                                            : null,
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
                      _buildDescription(state, task),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: state.onNameEditCancel,
                child: const Text('Cancel'),
              ),
              W.small,
              FilledButton(
                onPressed: state.onNameSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDescription(TaskDetailsState state, TaskDetails task) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        child: Card.filled(
          margin: const EdgeInsets.all(Margin.xLarge),
          child: Padding(
            padding: const EdgeInsets.all(Margin.medium),
            child: task.description == null
                ? SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No description added yet.',
                        style: state.context.bodySmall.copyWith(
                          color:
                              state.context.cs.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  )
                : Text(task.description ?? ''),
          ),
        ),
      ),
    );
  }
}

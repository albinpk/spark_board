import '../../providers/task_comment_list_provider.dart';
import '../../services/api/models/task_comments_response.dart';
import '../../services/api/models/task_details_response.dart';
import '../../utils/common.dart';
import '../tasks/enums/task_status.dart';
import '../tasks/models/task_model.dart';
import '../tasks/widgets/assign_dropdown.dart';
import 'models/comment_more_option_enum.dart';
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
    final commentsProvider = taskCommentListProvider(
      projectId: projectId,
      taskId: taskId,
    );

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
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.radio_button_off,
                                          size: 14,
                                        ),
                                        W.medium,
                                        Text(
                                          'Status',
                                          style: labelStyle,
                                        ),
                                      ],
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
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.group_outlined,
                                          size: 14,
                                        ),
                                        W.medium,
                                        Text(
                                          'Assigned to',
                                          style: labelStyle,
                                        ),
                                      ],
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
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.event_outlined,
                                          size: 14,
                                        ),
                                        W.medium,
                                        Text(
                                          'Created at',
                                          style: labelStyle,
                                        ),
                                      ],
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
                  tabs: [
                    const Tab(child: Text('Description')),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Comments'),

                          // comments count
                          if (task.totalComments > 0) ...[
                            W.small,
                            Card.filled(
                              color: context.cs.surfaceContainerHighest,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Margin.xSmall,
                                ),
                                child: Text(
                                  '${task.totalComments}',
                                  style: context.labelSmall,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: TabBarView(
                    controller: state.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // task description
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildTaskDescription(state, task),
                          ],
                        ),
                      ),

                      // comments
                      Column(
                        children: [
                          _commentInput(state),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                return Shimmer(
                                  value: ref.watch(commentsProvider),
                                  mock: CommentData(
                                    comment: BoneMock.paragraph,
                                    commentId: '1',
                                    createdAt: DateTime.now(),
                                  ).asList(3),
                                  builder: (comments) {
                                    if (comments.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No comments yet.',
                                          style: context.bodyMedium.copyWith(
                                            color: context.cs.onSurface
                                                .withValues(alpha: 0.5),
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.separated(
                                      itemCount: comments.length,
                                      padding: const EdgeInsets.all(
                                        Margin.xLarge,
                                      ).copyWith(bottom: 50),
                                      itemBuilder: (context, index) {
                                        return _buildComment(
                                          state,
                                          comments[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          height: Margin.xxLarge,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget _commentInput(TaskDetailsState state) {
    return Padding(
      padding: const EdgeInsets.all(Margin.xLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: state.commentController,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
              ),
            ),
          ),
          W.medium,
          IconButton.filledTonal(
            tooltip: 'Send',
            onPressed: state.addComment,
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(TaskDetailsState state, CommentData comment) {
    var isMoreOptionVisible = false;
    return Hovered(
      builder: (context, isHovered) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              maxRadius: 18,
              child: Icon(Icons.person),
            ),
            W.large,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        // TODO(albin): author name
                        'Albin PK',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      W.large,
                      Tooltip(
                        message: comment.createdAt.formatLong(),
                        child: Text(
                          comment.createdAt.fromNow(),
                          style: context.bodySmall,
                        ),
                      ),
                      const Spacer(),

                      // more options
                      SizedBox.square(
                        dimension: 30,
                        child: isHovered || isMoreOptionVisible
                            ? PopupMenuButton<CommentMoreOption>(
                                padding: EdgeInsets.zero,
                                iconSize: 18,
                                onOpened: () => isMoreOptionVisible = true,
                                onCanceled: () => isMoreOptionVisible = false,
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) {
                                  _onCommentOption(
                                    state,
                                    comment,
                                    value,
                                  );
                                },
                                itemBuilder: (context) {
                                  return CommentMoreOption.values.map((e) {
                                    return PopupMenuItem(
                                      value: e,
                                      child: Text(e.name.capitalize),
                                    );
                                  }).toList();
                                },
                              )
                            : null,
                      ),
                    ],
                  ),
                  Text(comment.comment),
                ],
              ),
            ),
          ],
        );
      },
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

  Future<void> _onCommentOption(
    TaskDetailsState state,
    CommentData comment,
    CommentMoreOption value,
  ) async {
    switch (value) {
      case CommentMoreOption.delete:
        final confirmed = await confirmDialog(
          context: state.context,
          description: 'Are you sure you want to delete this comment?',
        );
        if (confirmed) await state.deleteComment(comment);
    }
  }
}

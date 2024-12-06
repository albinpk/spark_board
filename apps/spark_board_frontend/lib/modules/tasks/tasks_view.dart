import 'dart:math';

import '../../utils/common.dart';
import 'enums/task_status.dart';
import 'tasks_state.dart';
import 'widgets/task_card.dart';

class TasksView extends CoraConsumerView<TasksState> {
  const TasksView({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  TasksState createState() => TasksState();

  @override
  Widget build(BuildContext context, TasksState state) {
    return TaskStateProvider(
      state: state,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final child = CustomScrollView(
              controller: state.scrollController,
              slivers: [
                SliverCrossAxisGroup(
                  slivers: [
                    _buildGridList(state, TaskStatus.todo),
                    _buildGridList(state, TaskStatus.inProgress),
                    _buildGridList(state, TaskStatus.done),
                  ],
                ),
              ],
            );

            const minWidth = TaskCard.width * 3 + 30;
            if (constraints.maxWidth > minWidth) return child;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: minWidth,
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridList(TasksState state, TaskStatus status) {
    final taskList = state.tasks[status] ?? [];
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _Sticky(
            status: status,
            onTapAdd: () => state.onTapAdd(status),
          ),
        ),
        SliverLayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.crossAxisExtent;
            return SliverPadding(
              padding: const EdgeInsets.all(
                Margin.medium,
              ).copyWith(right: maxWidth % TaskCard.width),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: max(1, maxWidth ~/ TaskCard.width),
                  mainAxisExtent: TaskCard.height,
                  mainAxisSpacing: Margin.medium,
                  crossAxisSpacing: Margin.medium,
                ),
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    key: ValueKey(taskList[index]),
                    task: taskList[index],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SmallIconButton extends StatelessWidget {
  const _SmallIconButton({
    required this.onPressed,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Margin.xSmall),
          child: Icon(
            iconData,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _Sticky extends SliverPersistentHeaderDelegate {
  const _Sticky({
    required this.status,
    required this.onTapAdd,
  });

  final TaskStatus status;
  final VoidCallback onTapAdd;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Margin.medium,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.cs.surface,
          border: Border(
            left: BorderSide(
              width: 4,
              color: status.color,
            ),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              W.medium,
              Expanded(
                child: Text(
                  status.label,
                  style: context.titleSmall,
                ),
              ),
              _SmallIconButton(
                onPressed: onTapAdd,
                iconData: Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 25;

  @override
  bool shouldRebuild(covariant _Sticky oldDelegate) => false;
}

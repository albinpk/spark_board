import 'dart:math';

import '../../utils/common.dart';
import 'tasks_state.dart';

class TasksView extends CoraConsumerView<TasksState> {
  const TasksView({super.key});

  @override
  TasksState createState() => TasksState();

  @override
  Widget build(BuildContext context, TasksState state) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final child = CustomScrollView(
            slivers: [
              SliverCrossAxisGroup(
                slivers: [
                  _buildGridList(state, _Status.todo),
                  _buildGridList(state, _Status.inProgress),
                  _buildGridList(state, _Status.done),
                ],
              ),
            ],
          );

          const minWidth = _width * 3 + 30;
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
    );
  }

  Widget _buildGridList(TasksState state, _Status status) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _Sticky(status),
        ),
        SliverLayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.crossAxisExtent;
            return SliverPadding(
              padding: const EdgeInsets.all(
                Margin.medium,
              ).copyWith(right: maxWidth % _width),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: max(1, maxWidth ~/ _width),
                  mainAxisExtent: _height,
                  mainAxisSpacing: Margin.medium,
                  crossAxisSpacing: Margin.medium,
                ),
                itemBuilder: (context, index) {
                  return _buildCard(context, status);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  static const _width = 140.0;
  static const _height = 80.0;

  Widget _buildCard(BuildContext context, _Status status) {
    final border = BorderSide(
      width: 0.3,
      color: status.color,
    );
    return SizedBox(
      height: _height,
      width: _width,
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
            children: [
              Expanded(
                child: Text(
                  'Lorem ipsum dolor sit ' * 4,
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

enum _Status {
  todo(Colors.purple),
  inProgress(Colors.orange),
  done(Colors.green);

  const _Status(this.color);
  final Color color;
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
  const _Sticky(this.status);

  final _Status status;

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
                  status.name.capitalize,
                  style: context.titleSmall,
                ),
              ),
              _SmallIconButton(
                onPressed: () {},
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

import '../../utils/common.dart';
import 'tasks_state.dart';

class TasksView extends CoraConsumerView<TasksState> {
  const TasksView({super.key});

  @override
  TasksState createState() => TasksState();

  @override
  Widget build(BuildContext context, TasksState state) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Margin.small,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final column = Column(
              children: [
                Row(
                  children: [
                    _buildTitle(context, _Status.todo),
                    W.small,
                    _buildTitle(context, _Status.inProgress),
                    W.small,
                    _buildTitle(context, _Status.done),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: Margin.large * 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTasks(context, _Status.todo),
                        _buildTasks(context, _Status.inProgress),
                        _buildTasks(context, _Status.done),
                      ],
                    ),
                  ),
                ),
              ],
            );

            const minWidth = 430.0;
            if (constraints.maxWidth > minWidth) return column;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: minWidth,
                child: column,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTasks(BuildContext context, _Status status) {
    return Expanded(
      child: Wrap(
        children: [
          for (int i = 0; i < 5; i++) _buildCard(context, status),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, _Status status) {
    final border = BorderSide(
      width: 0.3,
      color: status.color,
    );
    return SizedBox(
      height: 80,
      width: 140,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(Margin.small),
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

  Widget _buildTitle(BuildContext context, _Status status) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 4,
              color: status.color,
            ),
          ),
        ),
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
    super.key,
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

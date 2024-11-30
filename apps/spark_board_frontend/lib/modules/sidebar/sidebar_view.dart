import 'package:go_router/go_router.dart';

import '../../utils/common.dart';
import 'sidebar_state.dart';

class SidebarView extends CoraConsumerView<SidebarState> {
  const SidebarView({
    required this.projectId,
    super.key,
  });

  final String projectId;

  @override
  SidebarState createState() => SidebarState();

  @override
  Widget build(BuildContext context, SidebarState state) {
    final url = GoRouterState.of(context).uri.toString();
    bool isStartsWith(String path) =>
        url.startsWith('/projects/$projectId/$path');

    return SizedBox(
      width: state.widthAnimation.value,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: state.dividerColor.value ?? Colors.transparent,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              margin: state.projectSwitchPadding.value,
              color: context.cs.surfaceContainer,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  state.projectSwitchRadius.value,
                ),
              ),
              child: SizedBox.square(
                dimension: state.projectSwitchSize.value,
                child: InkWell(
                  onTap: () {},
                  child: const Center(
                    child: Icon(Icons.swap_horiz_rounded),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Margin.medium),
                child: Column(
                  children: [
                    _buildTile(
                      state: state,
                      iconData: Icons.checklist,
                      selected: isStartsWith('tasks'),
                      label: 'Tasks',
                      onTap: () {
                        TasksRoute(projectId: projectId).go(context);
                      },
                    ),
                    _buildTile(
                      state: state,
                      selected: isStartsWith('user'),
                      iconData: Icons.people_alt_outlined,
                      label: 'Users',
                      onTap: () {
                        UsersRoute(projectId: projectId).go(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildSidebarButton(state),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarButton(SidebarState state) {
    final borderRadius = BorderRadius.circular(Margin.medium);
    return Padding(
      padding: const EdgeInsets.all(Margin.medium),
      child: InkWell(
        onTap: state.toggleExpand,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(Margin.xxSmall),
          alignment: state.collapseIconAlign.value,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: state.context.cs.surfaceContainerHighest,
            ),
          ),
          child: Transform.rotate(
            angle: state.collapseIconRotation.value,
            child: Icon(
              Icons.keyboard_double_arrow_left_rounded,
              color: state.context.cs.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required SidebarState state,
    required IconData iconData,
    required String label,
    required VoidCallback onTap,
    required bool selected,
  }) {
    final borderRadius = BorderRadius.circular(Margin.medium);
    return Padding(
      padding: const EdgeInsets.only(bottom: Margin.small),
      child: Material(
        borderRadius: borderRadius,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Ink(
            color: selected ? state.context.cs.surfaceContainer : null,
            child: Container(
              padding: state.itemPadding.value,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: selected
                      ? state.context.cs.surfaceContainerHighest
                      : Colors.transparent,
                ),
              ),
              alignment: state.itemIconAlign.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: state.itemIconPadding.value,
                    child: Icon(iconData, size: 18),
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1 - state.curve.value,
                      child: Text(label),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

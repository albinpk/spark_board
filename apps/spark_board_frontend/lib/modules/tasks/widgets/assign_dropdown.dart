import 'package:scroll_animator/scroll_animator.dart';

import '../../../providers/staff_list_provider.dart';
import '../../../services/api/models/staffs_response.dart';
import '../../../utils/common.dart';
import '../models/task_model.dart';

class AssignDropdown extends ConsumerStatefulWidget {
  const AssignDropdown({
    required this.task,
    required this.onAssign,
    super.key,
  });

  final TaskModel task;
  final ValueChanged<StaffResponse> onAssign;

  @override
  ConsumerState<AssignDropdown> createState() => _AssignDropdownState();
}

class _AssignDropdownState extends ConsumerState<AssignDropdown> {
  final _searchTextController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final _scrollController = AnimatedScrollController(
    animationFactory: const ChromiumEaseInOut(),
  );

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  TaskModel get task => widget.task;

  @override
  Widget build(BuildContext context) {
    final staffs = ref.watch(staffListProvider).valueOrNull;

    if (staffs == null) {
      return const SizedBox.square(
        dimension: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.cs.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Drop(
        dropBuilder: (context, controller) {
          return SizedBox(
            height: 130,
            child: ScrollbarTheme(
              data: context.theme.scrollbarTheme.copyWith(
                thickness: const WidgetStatePropertyAll(2),
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: ListenableBuilder(
                  listenable: _searchTextController,
                  builder: (context, child) {
                    return DropChild(
                      children: [
                        for (final staff in staffs.where(
                          (e) => e.name.toLowerCase().contains(
                                _searchTextController.text.trim().toLowerCase(),
                              ),
                        ))
                          DropItem(
                            label: staff.name,
                            onTap: () {
                              controller.hide();
                              setState(() {});
                              _searchTextController.clear();
                              widget.onAssign(staff);
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        childBuilder: (context, controller) {
          return controller.isShowing
              ? _buildSearchField()
              : InkWell(
                  onTap: () {
                    controller.show();
                    setState(() {});
                    _searchTextController.clear();
                    _searchFocusNode.requestFocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            task.assignee?.name ?? 'Assign',
                            style: context.bodyMedium.copyWith(
                              color: task.assignee == null
                                  ? context.cs.onSurface.withValues(alpha: 0.4)
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: context.cs.onSurface.withValues(alpha: 0.7),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      focusNode: _searchFocusNode,
      autofocus: true,
      cursorHeight: 10,
      style: context.bodyMedium,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Margin.xSmall,
        ),
      ),
    );
  }
}

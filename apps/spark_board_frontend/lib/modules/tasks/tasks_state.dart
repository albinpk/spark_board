import 'package:scroll_animator/scroll_animator.dart';

import '../../utils/common.dart';
import 'tasks_view.dart';

class TasksState extends CoraConsumerState<TasksView> {
  final scrollController = AnimatedScrollController(
    animationFactory: const ChromiumEaseInOut(),
  );

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

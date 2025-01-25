import 'dart:math';

import '../../utils/common.dart';
import 'sidebar_view.dart';

class SidebarState extends CoraConsumerState<SidebarView>
    with ObsStateMixin, SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  static const _maxWidth = 200.0;
  static const _minWidth = 50.0;

  late final widthAnimation = Tween<double>(
    begin: _maxWidth,
    end: _minWidth,
  ).animate(curve);

  late final projectSwitchSize = Tween<double>(
    begin: 40,
    end: _minWidth,
  ).animate(curve);

  late final projectSwitchRadius = Tween<double>(
    begin: Margin.large,
    end: 0,
  ).animate(curve);

  late final projectSwitchPadding = EdgeInsetsTween(
    begin: const EdgeInsets.all(Margin.medium),
    end: EdgeInsets.zero,
  ).animate(curve);

  late final dividerColorOpacity = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(curve);

  late final itemIconAlign = AlignmentTween(
    begin: Alignment.centerLeft,
    end: Alignment.center,
  ).animate(curve);

  late final itemPadding = EdgeInsetsTween(
    begin: const EdgeInsets.all(Margin.small),
    end: const EdgeInsets.all(Margin.xxSmall),
  ).animate(curve);

  late final itemIconPadding = EdgeInsetsTween(
    begin: const EdgeInsets.only(
      left: Margin.medium,
      right: Margin.large,
    ),
    end: EdgeInsets.zero,
  ).animate(curve);

  late final collapseIconAlign = AlignmentTween(
    begin: Alignment.centerRight,
    end: Alignment.center,
  ).animate(curve);

  late final collapseIconRotation = Tween<double>(
    begin: 0,
    end: pi,
  ).animate(curve);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    onDispose(curve.dispose);
    onDispose(_controller.dispose);
  }

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // close sidebar on small screen
    if (!_initialized && context.width < 900) {
      _initialized = true;
      _controller.value = 1;
    }
  }

  void toggleExpand() {
    if (curve.isCompleted) {
      _controller.reverse();
    } else if (curve.isDismissed) {
      _controller.forward();
    }
  }
}

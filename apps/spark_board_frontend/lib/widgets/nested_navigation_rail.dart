import '../utils/common.dart';

/// Left navigation rail.
class NestedNavigationRail extends StatelessWidget {
  const NestedNavigationRail({
    required this.items,
    super.key,
  });

  final List<NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.cs.primaryContainer,
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: Margin.large),
                child: Column(
                  children: [
                    for (final e in items) _Item(item: e, depth: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class NavItem {
  const NavItem({
    this.icon,
    this.label,
    this.child,
    this.isSelected = false,
    this.onTap,
    // this.items = const [],
  }) : assert(
          icon != null || label != null || child != null,
          'icon, label or child should be provided',
        );

  final Widget? icon;
  final String? label;
  final Widget? child;
  final bool isSelected;
  final VoidCallback? onTap;
  List<NavItem> get items => [];
}

class _Item extends StatefulWidget {
  const _Item({
    required this.item,
    required this.depth,
  });

  final NavItem item;
  final int depth;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool _expanded = false;

  NavItem get item => widget.item;

  static const _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    final child = item.child ??
        ListTile(
          dense: true,
          onTap: _onTap,
          leading: item.icon,
          selected: item.isSelected,
          selectedColor: context.cs.onPrimary,
          selectedTileColor: context.cs.primary,
          title: item.label == null ? null : Text(item.label!),
          trailing: item.items.isEmpty
              ? null
              : AnimatedRotation(
                  turns: _expanded ? -0.5 : 0,
                  duration: _duration,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: context.cs.onPrimaryContainer.withValues(alpha: 0.5),
                  ),
                ),
        );
    if (item.items.isEmpty) return child;

    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: _duration,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: _expanded
            ? context.cs.primaryContainer.darken(10 * widget.depth + 3)
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            child,
            AnimatedAlign(
              alignment: Alignment.topCenter,
              duration: _duration,
              heightFactor: _expanded ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRect(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final e in item.items)
                        _Item(
                          item: e,
                          depth: widget.depth + 1,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (item.items.isNotEmpty) {
      return setState(() => _expanded = !_expanded);
    }
    item.onTap?.call();
  }
}

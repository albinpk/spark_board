import '../utils/common.dart';

/// Custom drop down widget.
class Drop extends StatefulWidget {
  const Drop({
    required this.childBuilder,
    required this.dropBuilder,
    super.key,
  });

  final Widget Function(
    BuildContext context,
    OverlayPortalController controller,
  ) childBuilder;

  final Widget Function(
    BuildContext context,
    OverlayPortalController controller,
  ) dropBuilder;

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  final _overlayController = OverlayPortalController();
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            showWhenUnlinked: false,
            link: _layerLink,
            targetAnchor: Alignment.bottomLeft,
            child: TapRegion(
              onTapOutside: (event) {
                _overlayController.hide();
                setState(() {});
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: widget.dropBuilder(context, _overlayController),
              ),
            ),
          );
        },
        child: widget.childBuilder(context, _overlayController),
      ),
    );
  }
}

class DropChild extends StatelessWidget {
  const DropChild({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: context.cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.cs.surfaceContainerHighest,
        ),
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class DropItem extends StatelessWidget {
  const DropItem({
    required this.onTap,
    super.key,
    this.child,
    this.label,
  }) : assert(
          label != null || child != null,
          'Either label or child must be provided',
        );

  final Widget? child;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Margin.medium,
          vertical: Margin.xSmall,
        ).copyWith(right: Margin.xxLarge),
        child: child ??
            Text(
              label!,
              style: context.labelSmall,
            ),
      ),
    );
  }
}

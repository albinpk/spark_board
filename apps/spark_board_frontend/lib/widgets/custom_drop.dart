import '../utils/common.dart';

/// Customized [PopupMenuButton].
class CustomDrop<T> extends StatelessWidget {
  const CustomDrop({
    required this.itemBuilder,
    required this.childBuilder,
    super.key,
    this.initialValue,
    this.onSelected,
    this.color,
    this.position,
    this.menuPadding,
  });

  final PopupMenuItemBuilder<T> itemBuilder;

  final T? initialValue;

  final PopupMenuItemSelected<T>? onSelected;

  final Widget Function(BuildContext context, VoidCallback show) childBuilder;

  final Color? color;

  final PopupMenuPosition? position;

  final EdgeInsetsGeometry? menuPadding;

  @override
  Widget build(BuildContext context) {
    return childBuilder(context, () => showButtonMenu(context));
  }

  void showButtonMenu(BuildContext context) {
    final popupMenuTheme = PopupMenuTheme.of(context);
    final button = context.findRenderObject()! as RenderBox;
    final overlay = Navigator.of(
      context,
    ).overlay!.context.findRenderObject()! as RenderBox;
    final popupMenuPosition =
        this.position ?? popupMenuTheme.position ?? PopupMenuPosition.over;
    final Offset offset;
    switch (popupMenuPosition) {
      case PopupMenuPosition.over:
        offset = Offset.zero;
      case PopupMenuPosition.under:
        offset = Offset(0, button.size.height) + Offset.zero;
    }
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero) + offset,
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    final items = itemBuilder(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: context,
        elevation: popupMenuTheme.elevation,
        shadowColor: popupMenuTheme.shadowColor,
        surfaceTintColor: popupMenuTheme.surfaceTintColor,
        items: items,
        initialValue: initialValue,
        position: position,
        shape: popupMenuTheme.shape,
        menuPadding: menuPadding ?? popupMenuTheme.menuPadding,
        color: color ?? popupMenuTheme.color,
      ).then<void>((T? newValue) {
        if (!context.mounted) return null;
        if (newValue == null) return null;
        onSelected?.call(newValue);
      });
    }
  }
}

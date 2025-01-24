import '../../../utils/common.dart';

/// Input cell in table.
class InputCell extends StatefulWidget {
  const InputCell({
    required this.value,
    required this.onChanged,
    super.key,
    this.style,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final TextStyle? style;

  @override
  State<InputCell> createState() => _InputCellState();
}

class _InputCellState extends State<InputCell> with ObsStateMixin {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _isEditMode.setFalse();
        _isHovered.setFalse();
      }
    });
    onDispose(_focusNode.dispose);
  }

  late final _isHovered = obs(false);
  late final _isEditMode = obs(false);

  @override
  Widget build(BuildContext context) {
    if (_isEditMode.value) {
      final border = OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.5,
          color: context.cs.primary,
        ),
      );

      return TextFormField(
        initialValue: widget.value,
        autofocus: true,
        focusNode: _focusNode,
        style: widget.style,
        cursorHeight: 15,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Margin.small,
            vertical: Margin.small,
          ),
          enabledBorder: border,
          focusedBorder: border,
        ),
        onFieldSubmitted: widget.onChanged,
      );
    }

    return MouseRegion(
      onEnter: (_) => _isHovered.setTrue(),
      onExit: (_) => _isHovered.setFalse(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.value,
              maxLines: 1,
              style: widget.style,
            ),
          ),
          if (_isHovered.value) _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: _isEditMode.setTrue,
        child: Padding(
          padding: const EdgeInsets.all(Margin.xSmall),
          child: Icon(
            Icons.edit,
            size: 14,
            color: context.cs.onSurface.fade(0.5),
          ),
        ),
      ),
    );
  }
}

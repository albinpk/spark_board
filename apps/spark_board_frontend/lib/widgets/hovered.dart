import 'package:flutter/material.dart';

/// A widget that builds based on hover state.
class Hovered extends StatefulWidget {
  const Hovered({
    required this.builder,
    super.key,
  });

  // ignore: avoid_positional_boolean_parameters
  final Widget Function(BuildContext context, bool isHovered) builder;

  @override
  State<Hovered> createState() => _HoveredState();
}

class _HoveredState extends State<Hovered> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.builder(context, _isHovered),
    );
  }
}

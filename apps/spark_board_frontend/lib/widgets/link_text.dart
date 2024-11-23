import 'package:flutter/gestures.dart';

import '../utils/common.dart';

/// Creates clickable links in text.
class LinkText extends StatefulWidget {
  const LinkText(
    this.data, {
    this.style,
    super.key,
  });

  /// List of record of text and callback function.
  /// If the callback is not null, the text will be clickable.
  final List<(String text, VoidCallback? onTap)> data;

  final TextStyle? style;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  final Map<int, TapGestureRecognizer> _recognizers = {};

  @override
  void initState() {
    super.initState();
    for (final (i, (_, onTap)) in widget.data.indexed) {
      if (onTap != null) {
        _recognizers[i] = TapGestureRecognizer()..onTap = onTap;
      }
    }
  }

  @override
  void dispose() {
    for (final e in _recognizers.values) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: widget.style,
      TextSpan(
        children: [
          for (final (i, (text, onTap)) in widget.data.indexed)
            TextSpan(
              text: text,
              style: onTap == null
                  ? null
                  : TextStyle(
                      color: context.cs.primary,
                    ),
              recognizer: _recognizers[i],
            ),
        ],
      ),
    );
  }
}

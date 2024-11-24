import 'package:flutter/material.dart';

/// Margin and Padding constants.
abstract final class Margin {
  static const double xxSmall = 2;
  static const double xSmall = 4;
  static const double small = 6;
  static const double medium = 8;
  static const double large = 12;
  static const double xLarge = 16;
  static const double xxLarge = 20;
}

/// Height widget.
class H extends StatelessWidget {
  const H(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);

  static const xxSmall = H(Margin.xxSmall);
  static const xSmall = H(Margin.xSmall);
  static const small = H(Margin.small);
  static const medium = H(Margin.medium);
  static const large = H(Margin.large);
  static const xLarge = H(Margin.xLarge);
  static const xxLarge = H(Margin.xxLarge);
}

/// Width widget.
class W extends StatelessWidget {
  const W(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width);

  static const xxSmall = W(Margin.xxSmall);
  static const xSmall = W(Margin.xSmall);
  static const small = W(Margin.small);
  static const medium = W(Margin.medium);
  static const large = W(Margin.large);
  static const xLarge = W(Margin.xLarge);
  static const xxLarge = W(Margin.xxLarge);
}

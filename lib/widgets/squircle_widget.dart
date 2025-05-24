import 'package:flutter/material.dart';

class SquircleWidget extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? borderSide;
  final double borderRadius;
  const SquircleWidget({
    super.key,
    this.color,
    required this.child,
    this.borderSide,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: color ?? Colors.transparent,
          width: borderSide ?? 0,
        ),
      ),
      child: child,
    );
  }
}

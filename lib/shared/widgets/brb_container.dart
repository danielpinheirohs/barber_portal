import 'package:flutter/material.dart';

class BRBContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final Widget? child;
  final double? padding;
  final double? margin;
  final bool elevation;
  final BoxBorder? border;
  final BoxConstraints? constraints;

  const BRBContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation = false,
    this.border,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: EdgeInsets.all(padding ?? 24),
      margin: margin == null ? null : EdgeInsets.all(margin!),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
        border: border,
        boxShadow: elevation
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

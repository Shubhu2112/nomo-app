import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerContainer extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final double? height;
  final double? width;
  final Widget? child;
  const CommonShimmerContainer({
    super.key,
    this.baseColor,
    this.height,
    this.highlightColor,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Theme.of(context).colorScheme.onSurface,
      highlightColor: highlightColor ?? Colors.white,
      child: child ??
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
              color: Colors.white,
            ),
            width: width,
            height: height ?? 30,
          ),
    );
  }
}

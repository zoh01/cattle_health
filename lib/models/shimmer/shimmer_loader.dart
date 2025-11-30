import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key, this.height = 120});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white70,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
        ),
        margin: const EdgeInsets.only(bottom: 16),
      ),
    );
  }
}
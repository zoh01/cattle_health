import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ValueCard extends StatefulWidget {
  const ValueCard({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.prevValue,
    required this.unit,
    required this.validator,
  });

  final String image;
  final String title;
  final String? value;
  final String? prevValue;
  final String unit;
  final bool Function(double p1) validator;

  @override
  State<ValueCard> createState() => _ValueCardState();
}

class _ValueCardState extends State<ValueCard> {
  bool shimmer = true;

  @override
  void initState() {
    loadShimmer();
    super.initState();
  }

  loadShimmer() async {
    await Future.delayed(Duration(milliseconds: 5000));
    setState(() {
      shimmer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey.shade300;

    if (widget.value != null) {
      final double? val = double.tryParse(widget.value!);
      if (val != null) {
        if (widget.validator(val)) {
          bgColor = Colors.green.shade400;
        } else {
          bgColor = Colors.red.shade400;
        }
      }
    }

    /// Calculate Difference (Latest - Previous)
    double? difference;
    if (widget.value != null && widget.prevValue != null) {
      final latest = double.tryParse(widget.value!);
      final prev = double.tryParse(widget.prevValue!);
      if (latest != null && prev != null) {
        difference = latest - prev;
      }
    }

    return shimmer
        ? Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.transparent,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(ZohSizes.md),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ZohSizes.md),
                      color: Colors.grey.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(ZohSizes.md),
                      child: Image(
                        image: AssetImage(widget.image),
                        fit: BoxFit.contain,
                        height: 70,
                        width: 60,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ZohSizes.md,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Text(
                            widget.value != null
                                ? "${widget.value} ${widget.unit}"
                                : "Pending...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ZohSizes.fontSizeSm,
                              fontFamily: "Inter",
                            ),
                          ),
                        ],
                      ),

                      /// Show PreValue if latest exist
                      if (widget.value != null && widget.prevValue != null)
                        Row(
                          children: [
                            Icon(
                              Icons.history_rounded,
                              color: ZohColors.darkerGrey,
                              size: ZohSizes.md,
                            ),
                            SizedBox(width: ZohSizes.sm),
                            Text(
                              "${widget.prevValue} ${widget.unit}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ZohSizes.iconXs,
                                fontFamily: "Inter",
                              ),
                            ),
                          ],
                        ),

                      /// Show Difference if available
                      if (difference != null)
                        Row(
                          children: [
                            Icon(
                              difference > 0
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: difference > 0 ? Colors.green : Colors.red,
                              size: ZohSizes.md,
                            ),
                            SizedBox(width: ZohSizes.sm),
                            Text(
                              "${difference.toStringAsFixed(2)} ${widget.unit}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ZohSizes.iconXs,
                                fontFamily: "Inter",
                                color:
                                    difference > 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        : Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(ZohSizes.md),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ZohSizes.md),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(ZohSizes.md),
                    child: Image(
                      image: AssetImage(widget.image),
                      fit: BoxFit.contain,
                      height: 70,
                      width: 60,
                    ),
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ZohSizes.md,
                    fontFamily: "Roboto",
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(ZohSizes.md),
                      child: Container(
                        padding: EdgeInsets.all(ZohSizes.sm),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(ZohSizes.md),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: ZohColors.darkerGrey,
                                  size: ZohSizes.defaultSpace,
                                ),
                                SizedBox(width: ZohSizes.sm),
                                Text(
                                  widget.value != null
                                      ? "${widget.value} ${widget.unit}"
                                      : "Pending...",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ZohSizes.md,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ],
                            ),
                            /// Show PreValue if latest exist
                            if (widget.value != null && widget.prevValue != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    color: ZohColors.darkerGrey,
                                    size: ZohSizes.spaceBtwZoh,
                                  ),
                                  SizedBox(width: ZohSizes.sm),
                                  Text(
                                    "${widget.prevValue} ${widget.unit}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ZohSizes.fontSizeSm,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ],
                              ),

                            /// Show Difference if available
                            if (difference != null)
                              Row(
                                children: [
                                  Icon(
                                    difference > 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: difference > 0 ? Colors.green : Colors.red,
                                    size: ZohSizes.spaceBtwZoh,
                                  ),
                                  SizedBox(width: ZohSizes.sm),
                                  Text(
                                    "${difference.toStringAsFixed(2)} ${widget.unit}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ZohSizes.fontSizeSm,
                                      fontFamily: "Inter",
                                      color: difference > 0 ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        );
  }
}

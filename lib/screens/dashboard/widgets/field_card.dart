import 'package:cattle_health/screens/dashboard/widgets/value_card.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({
    super.key,
    required this.bgColor,
    required this.widget,
    required this.difference,
    required this.diseasePrediction,
  });

  final Color bgColor;
  final ValueCard widget;
  final double? difference;
  final String? diseasePrediction;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(ZohSizes.md),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
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
                                  color: ZohColors.secondaryColor,
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
                            if (widget.value != null &&
                                widget.prevValue != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    color: ZohColors.secondaryColor,
                                    size: ZohSizes.defaultSpace,
                                  ),
                                  SizedBox(width: ZohSizes.sm),
                                  Text(
                                    "${widget.prevValue} ${widget.unit}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ZohSizes.md,
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
                                    difference! > 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color:
                                        difference! > 0
                                            ? Colors.green
                                            : Colors.red,
                                    size: ZohSizes.defaultSpace,
                                  ),
                                  SizedBox(width: ZohSizes.sm),
                                  Text(
                                    "${difference?.toStringAsFixed(2)} ${widget.unit}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ZohSizes.md,
                                      fontFamily: "Inter",
                                      color:
                                          difference! > 0
                                              ? Colors.green
                                              : Colors.red,
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

            SizedBox(height: ZohSizes.sm),

            /// Disease Prediction for each Field
            if (diseasePrediction != null)
              Material(
                borderRadius: BorderRadius.circular(ZohSizes.md),
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(ZohSizes.md),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem_outlined,
                          size: ZohSizes.defaultSpace,
                          color: ZohColors.primaryColor,
                        ),
                        SizedBox(width: ZohSizes.sm),
                        Text(
                          ":",
                          style: TextStyle(fontSize: ZohSizes.defaultSpace),
                        ),
                        SizedBox(width: ZohSizes.sm),
                        Text(
                          diseasePrediction!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ZohSizes.spaceBtwZoh,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

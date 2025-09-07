import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';

class HealthCard extends StatefulWidget {
  const HealthCard({super.key, required this.status});

  final String status;

  @override
  State<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard> {
  bool shimmer = true;

  @override
  void initState() {
    loadShimmer();
    super.initState();
  }

  loadShimmer() async {
    await Future.delayed(Duration(milliseconds: 4000));
    setState(() {
      shimmer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey.shade300;
    String healthImage = ZohImages.report;

    if (widget.status.contains("Healthy")) {
      bgColor = Colors.green.shade400;
      healthImage = ZohImages.check;
    } else if (widget.status.contains("Issues")) {
      bgColor = Colors.red.shade400;
      healthImage = ZohImages.report;
    }

    return shimmer
        ? Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.transparent,
          child: Material(
            borderRadius: BorderRadius.circular(ZohSizes.md),
            elevation: 5,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(ZohSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ZohSizes.md),
                color: bgColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ZohSizes.md),
                        color: Colors.grey.shade400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(healthImage),
                          height: 70,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ZohSizes.defaultSpace),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Health Status",
                          style: TextStyle(
                            fontSize: ZohSizes.defaultSpace,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                        Text(
                          widget.status,
                          style: TextStyle(
                            fontSize: ZohSizes.md,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        : Material(
          borderRadius: BorderRadius.circular(ZohSizes.md),
          elevation: 5,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(ZohSizes.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ZohSizes.md),
              color: bgColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ZohSizes.md),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(healthImage),
                        height: 70,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ZohSizes.defaultSpace),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Health Status",
                        style: TextStyle(
                          fontSize: ZohSizes.defaultSpace,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        widget.status,
                        style: TextStyle(
                          fontSize: ZohSizes.md,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}

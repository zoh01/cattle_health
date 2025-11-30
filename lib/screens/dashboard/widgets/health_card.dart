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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bgColor, bgColor.withOpacity(0.85)],
        ),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.35),
            blurRadius: 12,
            offset: Offset(0, 6),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background element
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: EdgeInsets.all(ZohSizes.defaultSpace),
            child: Row(
              children: [
                // Icon container with modern elevation
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image(
                    image: AssetImage(healthImage),
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(width: ZohSizes.defaultSpace),

                // Content section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.sensors,
                            size: ZohSizes.defaultSpace,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          SizedBox(width: ZohSizes.sm),
                          Expanded(
                            child: Text(
                              "Overall Health Status",
                              style: TextStyle(
                                fontSize: ZohSizes.md,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Roboto",
                                color: Colors.white.withOpacity(0.95),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.status,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16),
    //     color: bgColor,
    //     boxShadow: [
    //       BoxShadow(
    //         color: bgColor.withOpacity(0.3),
    //         blurRadius: 12,
    //         offset: Offset(0, 6),
    //         spreadRadius: 1,
    //       ),
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.05),
    //         blurRadius: 4,
    //         offset: Offset(0, 2),
    //       ),
    //     ],
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.all(ZohSizes.defaultSpace),
    //     child: Row(
    //       children: [
    //         // Icon container with modern elevation
    //         Container(
    //           padding: EdgeInsets.all(14),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(14),
    //             color: Colors.white,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.08),
    //                 blurRadius: 8,
    //                 offset: Offset(0, 3),
    //               ),
    //             ],
    //           ),
    //           child: Image(
    //             image: AssetImage(healthImage),
    //             height: 50,
    //             width: 50,
    //             fit: BoxFit.contain,
    //           ),
    //         ),
    //
    //         SizedBox(width: ZohSizes.defaultSpace),
    //
    //         // Content section
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Text(
    //                 "Overall Health Status",
    //                 style: TextStyle(
    //                   fontSize: 13,
    //                   fontWeight: FontWeight.w600,
    //                   fontFamily: "Roboto",
    //                   color: Colors.white.withOpacity(0.95),
    //                   letterSpacing: 0.2,
    //                 ),
    //               ),
    //               SizedBox(height: 6),
    //               Text(
    //                 widget.status,
    //                 style: TextStyle(
    //                   fontSize: 19,
    //                   fontFamily: "Inter",
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white,
    //                   letterSpacing: 0.1,
    //                   height: 1.2,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

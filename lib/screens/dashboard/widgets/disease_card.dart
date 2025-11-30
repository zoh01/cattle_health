import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';

class DiseaseCard extends StatefulWidget {
  const DiseaseCard({super.key, required this.disease});

  final String disease;

  @override
  State<DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard> {
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
    Color bgColor = Colors.blue.shade300;
    String diseaseImage = ZohImages.healing;

    if (widget.disease.contains("No specific disease")) {
      bgColor = Colors.green.shade300;
      diseaseImage = ZohImages.check;
    } else if (widget.disease.contains("Possible")) {
      bgColor = Colors.red.shade300;
      diseaseImage = ZohImages.hospital;
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
                    image: AssetImage(diseaseImage),
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
                          SizedBox(width: 6),
                          Text(
                            "Disease Prediction",
                            style: TextStyle(
                              fontSize: ZohSizes.spaceBtwZoh,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto",
                              color: Colors.white.withOpacity(0.95),
                              letterSpacing: 0.2,
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
                                widget.disease,
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

    // return shimmer
    //     ? Shimmer.fromColors(
    //       baseColor: Colors.white70,
    //       highlightColor: Colors.transparent,
    //       child: Material(
    //         borderRadius: BorderRadius.circular(ZohSizes.md),
    //         elevation: 5,
    //         child: Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.all(ZohSizes.md),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(ZohSizes.md),
    //             color: bgColor,
    //           ),
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 flex: 2,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(ZohSizes.md),
    //                     color: Colors.grey.shade400,
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Image(
    //                       image: AssetImage(diseaseImage),
    //                       height: 70,
    //                       width: 60,
    //                       fit: BoxFit.contain,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: ZohSizes.defaultSpace),
    //               Expanded(
    //                 flex: 6,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Overall Disease Prediction",
    //                       style: TextStyle(
    //                         fontSize: ZohSizes.defaultSpace,
    //                         fontWeight: FontWeight.bold,
    //                         fontFamily: "Roboto",
    //                       ),
    //                     ),
    //                     Text(
    //                       widget.disease,
    //                       style: TextStyle(
    //                         fontSize: ZohSizes.md,
    //                         fontFamily: "Inter",
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     )
    //     : Material(
    //       borderRadius: BorderRadius.circular(ZohSizes.md),
    //       elevation: 5,
    //       child: Container(
    //         width: double.infinity,
    //         padding: EdgeInsets.all(ZohSizes.md),
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(ZohSizes.md),
    //           color: bgColor,
    //         ),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               flex: 2,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(ZohSizes.md),
    //                   color: Colors.grey.shade400,
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Image(
    //                     image: AssetImage(diseaseImage),
    //                     height: 70,
    //                     width: 60,
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: ZohSizes.defaultSpace),
    //             Expanded(
    //               flex: 6,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Disease Prediction",
    //                     style: TextStyle(
    //                       fontSize: ZohSizes.defaultSpace,
    //                       fontWeight: FontWeight.bold,
    //                       fontFamily: "Roboto",
    //                     ),
    //                   ),
    //                   Text(
    //                     widget.disease,
    //                     style: TextStyle(
    //                       fontSize: ZohSizes.md,
    //                       fontFamily: "Inter",
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
  }
}

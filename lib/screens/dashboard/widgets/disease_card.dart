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
                          image: AssetImage(diseaseImage),
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
                          "Overall Disease Prediction",
                          style: TextStyle(
                            fontSize: ZohSizes.defaultSpace,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                        Text(
                          widget.disease,
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
                        image: AssetImage(diseaseImage),
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
                        "Disease Prediction",
                        style: TextStyle(
                          fontSize: ZohSizes.defaultSpace,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        widget.disease,
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

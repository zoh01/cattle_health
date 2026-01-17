import 'package:flutter/material.dart';

import '../../../models/helper_class/disease_explanations.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';

class DiseaseCard extends StatefulWidget {
  const DiseaseCard({super.key, required this.disease});

  final String disease;

  @override
  State<DiseaseCard> createState() => _DiseaseCardState();

  // ✅ Helper method belongs to the widget
  DiseaseExplanation getExplanation() {
    return diseaseInfo.entries.firstWhere(
          (entry) => disease.contains(entry.key),
      orElse: () => MapEntry(
        "Unknown",
        DiseaseExplanation(
          title: "Unknown Condition",
          cause: "Insufficient data to determine the cause.",
          advice: "Continue monitoring sensor readings and consult a veterinarian.",
        ),
      ),
    ).value;
  }
}

class _DiseaseCardState extends State<DiseaseCard> {
  bool shimmer = true;

  @override
  void initState() {
    super.initState();
    loadShimmer();
  }

  Future<void> loadShimmer() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    if (mounted) {
      setState(() {
        shimmer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get explanation safely here
    final explanation = widget.getExplanation();

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
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ZohSizes.defaultSpace),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Image.asset(
                diseaseImage,
                height: 50,
                width: 50,
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Icon(
                        Icons.sensors,
                        size: 18,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Disease Prediction",
                        style: TextStyle(
                          fontSize: ZohSizes.spaceBtwZoh,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Disease name
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.disease,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Cause
                  Text(
                    "Cause:",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    explanation.cause,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Recommendation
                  Text(
                    "Recommendation:",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    explanation.advice,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
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

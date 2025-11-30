import 'package:cattle_health/utils/constants/colors.dart';
import 'package:cattle_health/utils/constants/image_string.dart';
import 'package:cattle_health/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../models/helper_class/health_score_helper.dart';

class HealthScoreCard extends StatelessWidget {
  final double ambient;
  final double humidity;
  final double bodyTemp;
  final double pulse;
  final double airQuality;

  const HealthScoreCard({
    super.key,
    required this.ambient,
    required this.humidity,
    required this.bodyTemp,
    required this.pulse,
    required this.airQuality,
  });

  @override
  Widget build(BuildContext context) {
    final score = computeHealthScore(
      ambientTemp: ambient,
      humidity: humidity,
      bodyTemp: bodyTemp,
      pulseRate: pulse,
      airQuality: airQuality,
    );

    final category = getHealthCategory(score);
    final color = getHealthColor(score);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.9),
            color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Decorative circles in background
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: EdgeInsets.all(ZohSizes.defaultSpace),
              child: Row(
                children: [
                  // Icon container with elevated design
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image(
                      image: AssetImage(ZohImages.report),
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
                      children: [
                        Text(
                          "Overall Health Score",
                          style: TextStyle(
                            fontSize: ZohSizes.md,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Score and category
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              score.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8, left: 4),
                              child: Text(
                                "%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 4),

                        // Category badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: ZohSizes.md,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto",
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),

                        SizedBox(height: 16),

                        // Progress bar with enhanced design
                        Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: score / 100,
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white.withOpacity(0.8),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
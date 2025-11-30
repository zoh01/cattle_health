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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor,
            bgColor.withOpacity(0.85),
          ],
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Decorative background elements
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(ZohSizes.defaultSpace),
              child: Column(
                children: [
                  // Top section with icon, title, and values
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon container
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
                          image: AssetImage(widget.image),
                          fit: BoxFit.contain,
                          height: 48,
                          width: 48,
                        ),
                      ),

                      SizedBox(width: ZohSizes.md),

                      // Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: "Roboto",
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Health Metric",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Colors.white.withOpacity(0.8),
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: ZohSizes.sm),

                      // Values container
                      _buildValuesContainer(),
                    ],
                  ),

                  // Disease prediction section
                  if (diseasePrediction != null && diseasePrediction!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: ZohSizes.md),
                      child: _buildDiseasePrediction(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuesContainer() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Current value
          _buildValueRow(
            icon: Icons.sensors,
            value: widget.value != null
                ? "${widget.value} ${widget.unit}"
                : "Pending...",
            isMain: true,
          ),

          // Previous value
          if (widget.value != null && widget.prevValue != null) ...[
            SizedBox(height: 8),
            _buildValueRow(
              icon: Icons.history_rounded,
              value: "${widget.prevValue} ${widget.unit}",
              isMain: false,
            ),
          ],

          // Difference
          if (difference != null) ...[
            SizedBox(height: 8),
            _buildDifferenceRow(),
          ],
        ],
      ),
    );
  }

  Widget _buildValueRow({
    required IconData icon,
    required String value,
    required bool isMain,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
        ),
        SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: isMain ? FontWeight.bold : FontWeight.w600,
            fontSize: isMain ? 15 : 13,
            fontFamily: "Inter",
            color: Colors.white,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildDifferenceRow() {
    final bool isPositive = difference! > 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isPositive ? Colors.green : Colors.red).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (isPositive ? Colors.green : Colors.red).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
            size: 14,
          ),
          SizedBox(width: 4),
          Text(
            "${difference!.abs().toStringAsFixed(2)} ${widget.unit}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "Inter",
              color: Colors.white,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseasePrediction() {
    final bool isNormal = diseasePrediction!.toLowerCase().contains("normal");

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isNormal
                  ? Colors.green
                  : Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isNormal ? Icons.check_circle_outline : Icons.medical_services_outlined,
              size: ZohSizes.spaceBtwZoh,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Diagnosis",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  diseasePrediction!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    color: Colors.black,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
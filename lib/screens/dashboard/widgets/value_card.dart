import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'field_card.dart';

class ValueCard extends StatefulWidget {
  const ValueCard({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.prevValue,
    required this.unit,
    required this.validator,
    required this.diseasePredictor,
  });

  final String image;
  final String title;
  final String? value;
  final String? prevValue;
  final String unit;
  final bool Function(double p1) validator;
  final String? Function(String title, double value) diseasePredictor;

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

    /// Disease Prediction
    String? diseasePrediction;
    if (widget.value != null) {
      final val = double.tryParse(widget.value!);
      if (val != null) {
        diseasePrediction = widget.diseasePredictor(widget.title, val);

        // If predictor returns null → means no disease → Normal
        if (diseasePrediction == null || diseasePrediction.isEmpty) {
          diseasePrediction = "Normal";
        }
      }
    }

    return shimmer
        ? Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: Colors.transparent,
          child: FieldCard(
            bgColor: bgColor,
            widget: widget,
            difference: difference,
            diseasePrediction: diseasePrediction,
          ),
        )
        : FieldCard(
          bgColor: bgColor,
          widget: widget,
          difference: difference,
          diseasePrediction: diseasePrediction,
        );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/helper_class/disease_explanations.dart';
import '../../../utils/constants/image_string.dart';

class DiseaseCard extends StatefulWidget {
  const DiseaseCard({super.key, required this.disease});

  final String disease;

  @override
  State<DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard>
    with SingleTickerProviderStateMixin {
  bool _isLoaded = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadData();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoaded = true);
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Extract diseases from prediction string
  List<String> _extractDiseases(String prediction) {
    if (!prediction.startsWith("Possible Disease")) {
      return [];
    }
    return prediction
        .replaceFirst("Possible Disease(s):", "")
        .split(",")
        .map((e) => e.trim())
        .toList();
  }

  // Get disease explanations
  List<DiseaseExplanation> _getExplanations() {
    final diseases = _extractDiseases(widget.disease);
    List<DiseaseExplanation> results = [];

    for (final disease in diseases) {
      if (diseaseInfo.containsKey(disease)) {
        results.add(diseaseInfo[disease]!);
      }
    }

    if (results.isEmpty) {
      results.add(
        DiseaseExplanation(
          title: "Normal Condition",
          cause: "All vital signs are within healthy ranges.",
          advice: "Continue routine monitoring and maintain healthy habits.",
        ),
      );
    }

    return results;
  }

  // Get disease severity level
  _DiseaseSeverity _getSeverity() {
    if (widget.disease.contains("No specific disease") ||
        widget.disease.contains("Normal")) {
      return _DiseaseSeverity.normal;
    } else if (widget.disease.contains("Possible")) {
      return _DiseaseSeverity.warning;
    }
    return _DiseaseSeverity.info;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return _buildShimmer();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildShimmer() {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    final severity = _getSeverity();
    final explanations = _getExplanations();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            severity.primaryColor,
            severity.primaryColor.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: severity.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(severity),
                const SizedBox(height: 16),
                _buildDiseaseInfo(),
                const SizedBox(height: 16),
                _buildExplanations(explanations),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(_DiseaseSeverity severity) {
    return Row(
      children: [
        // Icon Container
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            severity.iconPath,
            height: 40,
            width: 40,
          ),
        ),

        const SizedBox(width: 16),

        // Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    severity.statusIcon,
                    size: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Disease Prediction",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                severity.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Status Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            severity.badge,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiseaseInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_information_outlined,
                size: 16,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(width: 6),
              Text(
                "Diagnosis",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.disease,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanations(List<DiseaseExplanation> explanations) {
    return Column(
      children: explanations.map((exp) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildExplanationSection(exp),
        );
      }).toList(),
    );
  }

  Widget _buildExplanationSection(DiseaseExplanation explanation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cause Section
        _buildInfoRow(
          icon: Icons.info_outline,
          title: "Possible Cause",
          content: explanation.cause,
        ),
        const SizedBox(height: 12),

        // Advice Section
        _buildInfoRow(
          icon: Icons.lightbulb_outline,
          title: "Recommendation",
          content: explanation.advice,
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class for disease severity levels
class _DiseaseSeverity {
  final Color primaryColor;
  final String iconPath;
  final String title;
  final String badge;
  final IconData statusIcon;

  const _DiseaseSeverity({
    required this.primaryColor,
    required this.iconPath,
    required this.title,
    required this.badge,
    required this.statusIcon,
  });

  static _DiseaseSeverity get normal => _DiseaseSeverity(
    primaryColor: Colors.green.shade400,
    iconPath: ZohImages.check,
    title: "Healthy Status",
    badge: "Normal",
    statusIcon: Icons.check_circle_outline,
  );

  static _DiseaseSeverity get warning => _DiseaseSeverity(
    primaryColor: Colors.red.shade400,
    iconPath: ZohImages.hospital,
    title: "Attention Required",
    badge: "Warning",
    statusIcon: Icons.warning_amber_outlined,
  );

  static _DiseaseSeverity get info => _DiseaseSeverity(
    primaryColor: Colors.blue.shade400,
    iconPath: ZohImages.healing,
    title: "Health Analysis",
    badge: "Info",
    statusIcon: Icons.sensors,
  );
}
import 'dart:async';

import 'package:cattle_health/screens/dashboard/widgets/health_score_card.dart';
import 'package:cattle_health/utils/constants/image_string.dart';
import 'package:cattle_health/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../models/helper_class/disease_explanations.dart';
import '../../models/shimmer/shimmer_loader.dart';
import '../../services/api_data.dart';

import '../dashboard/widgets/value_card.dart';
import '../dashboard/widgets/disease_card.dart';
import '../dashboard/widgets/health_card.dart';

class ZohSpeakScreens extends StatefulWidget {
  const ZohSpeakScreens({super.key});

  @override
  State<ZohSpeakScreens> createState() => _ThingSpeakScreenState();
}

bool _alertShown = false;
class _ThingSpeakScreenState extends State<ZohSpeakScreens> {
  String? field1, field2, field3, field4, field5; // Current values
  String? prevField1,
      prevField2,
      prevField3,
      prevField4,
      prevField5; // Previous values

  Timer? _timer;
  String? _lastEntryId; // 🔑 to track new data

  @override
  void initState() {
    super.initState();
    _loadLatestData(); // Initial load

    // 🔄 Poll ThingSpeak every 15 seconds
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _checkForNewData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Load Latest Data On StartUp
  Future<void> _loadLatestData() async {
    final service = ThingSpeakService();
    final feed = await service.fetchLatestData();

    if (feed != null) {
      final String? newEntryId = feed["entry_id"]?.toString();
      _lastEntryId = newEntryId; // save entry_id
      _updateValues(feed);
    }
  }

  /// Check if new data is available before updating
  Future<void> _checkForNewData() async {
    final service = ThingSpeakService();
    final feed = await service.fetchLatestData();

    if (feed != null) {
      final String? newEntryId = feed["entry_id"]?.toString();

      // Update only if entry_id is new
      if (newEntryId != null && newEntryId != _lastEntryId) {
        _lastEntryId = newEntryId;
        _updateValues(feed);
      }
    }
  }

  /// Update values and save previous
  void _updateValues(Map<String, dynamic> feed) {
    setState(() {
      prevField1 = field1;
      prevField2 = field2;
      prevField3 = field3;
      prevField4 = field4;
      prevField5 = field5;

      field1 = _formatValue(feed["field1"]);
      field2 = _formatValue(feed["field2"]);
      field3 = _formatValue(feed["field3"]);
      field4 = _formatValue(feed["field4"]);
      field5 = _formatValue(feed["field5"]);
    });

    // 🔔 Trigger alert AFTER state update
    if (!_alertShown && isCriticalReading()) {
      _alertShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCriticalDialog();
      });
    }
  }

  String? _formatValue(dynamic value) {
    if (value == null) return null;
    final num? parsed = num.tryParse(value.toString());
    return parsed != null ? parsed.toStringAsFixed(2) : value.toString();
  }

  // ✅ Normal ranges
  bool isAmbientTempOK(double val) => val >= 15 && val <= 30;

  bool isHumidityOK(double val) => val >= 40 && val <= 70;

  bool isHeartRateOK(double val) => val >= 48 && val <= 84;

  bool isBodyTempOK(double val) => val >= 38 && val <= 39.5;

  bool isAirQualityOK(double val) => val <= 100;

  // 🔎 Detect cattle health status
  String detectCattleHealth() {
    final tempAmb = double.tryParse(field1 ?? "");
    final humidity = double.tryParse(field2 ?? "");
    final heart = double.tryParse(field3 ?? "");
    final tempBody = double.tryParse(field4 ?? "");
    final airQ = double.tryParse(field5 ?? "");

    if ([tempAmb, humidity, heart, tempBody, airQ].contains(null)) {
      return "⚠️ Not enough data to predict health";
    }

    bool ambOK = isAmbientTempOK(tempAmb!);
    bool humOK = isHumidityOK(humidity!);
    bool heartOK = isHeartRateOK(heart!);
    bool bodyOK = isBodyTempOK(tempBody!);
    bool airOK = isAirQualityOK(airQ!);

    if (ambOK && humOK && heartOK && bodyOK && airOK) {
      return "✅ Healthy (All vitals normal)";
    }

    List<String> issues = [];
    if (!ambOK) {
      issues.add(tempAmb > 30 ? "High Ambient Temp" : "Low Ambient Temp");
    }
    if (!humOK) issues.add(humidity > 70 ? "High Humidity" : "Low Humidity");
    if (!heartOK) issues.add(heart > 84 ? "High Heart Rate" : "Low Heart Rate");
    if (!bodyOK) {
      issues.add(tempBody > 39.5 ? "High Body Temp" : "Low Body Temp");
    }
    if (!airOK) issues.add("Poor Air Quality");
    return "Issues: ${issues.join(', ')}";
  }

  bool isCriticalReading() {
    final tempAmb = double.tryParse(field1 ?? "");
    final humidity = double.tryParse(field2 ?? "");
    final heart = double.tryParse(field3 ?? "");
    final tempBody = double.tryParse(field4 ?? "");
    final airQ = double.tryParse(field5 ?? "");

    if ([tempAmb, humidity, heart, tempBody, airQ].contains(null)) {
      return false;
    }

    return !isAmbientTempOK(tempAmb!) ||
        !isHumidityOK(humidity!) ||
        !isHeartRateOK(heart!) ||
        !isBodyTempOK(tempBody!) ||
        !isAirQualityOK(airQ!);
  }

  // Predict possible disease based on abnormal patterns
  String predictDisease() {
    final tempAmb = double.tryParse(field1 ?? "");
    final humidity = double.tryParse(field2 ?? "");
    final heart = double.tryParse(field3 ?? "");
    final tempBody = double.tryParse(field4 ?? "");
    final airQ = double.tryParse(field5 ?? "");

    if ([tempAmb, humidity, heart, tempBody, airQ].contains(null)) {
      return "⚠️ Not enough data for disease prediction";
    }

    List<String> diseases = [];

    if (tempBody! > 39.5 && heart! > 84) {
      diseases.add("Heat Stress");
    }
    if (tempBody < 38 && heart! < 48) {
      diseases.add("Hypothermia");
    }
    if (tempBody < 38 && humidity! > 70) {
      diseases.add("Ketosis");
    }
    if (tempAmb! > 30 && humidity! > 70) {
      diseases.add("Mastitis");
    }
    if (tempBody < 38 && heart! > 84) {
      diseases.add("Shock & Circulatory Collapse");
    }
    if (airQ! > 100 && heart! > 84) {
      diseases.add("Respiratory Issues");
    }

    if (diseases.isEmpty) {
      return "✅ No specific disease detected. Just monitor cattle.";
    }
    return "Possible Disease(s): ${diseases.join(', ')}";
  }

  String? getFieldDisease(String title, double value) {
    switch (title) {
      case "Ambient Temp":
        if (value > 30) return "Heat Stress Risk";
        if (value < 15) return "Cold Stress Risk";
        break;

      case "Humidity":
        if (value > 70) return "Pneumonia Risk";
        if (value < 40) return "Dehydration Risk";
        break;

      case "Heart Rate":
        if (value > 84) return "Fever / Infection Risk";
        if (value < 48) return "Shock Risk";
        break;

      case "Body Temp":
        if (value > 39.5) return "Fever / Mastitis";
        if (value < 38) return "Hypothermia Risk";
        break;

      case "Air Quality":
        if (value > 100) return "Respiratory Disease Risk";
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    if (field1 == null ||
        field2 == null ||
        field3 == null ||
        field4 == null ||
        field5 == null) {
      return Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(
          title: const Text(
            "Cattle Health Monitor",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: ZohSizes.defaultSpace,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white12,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ShimmerLoader(height: 150),
                ShimmerLoader(height: 150),
                ShimmerLoader(height: 150),
                ShimmerLoader(height: 150),
                ShimmerLoader(height: 150),
                SizedBox(height: 20),
                ShimmerLoader(height: 150), // For HealthScoreCard
              ],
            ),
          ),
        ),
      );
    }

    final healthStatus = detectCattleHealth();

    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text(
          "Cattle Health Monitor",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: ZohSizes.defaultSpace,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white12,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ZohSizes.md),
          child: Column(
            children: [
              ValueCard(
                image: ZohImages.ambientTemp,
                title: "Ambient Temp",
                value: field1,
                prevValue: prevField1,
                unit: "°C",
                validator: isAmbientTempOK,
                diseasePredictor: getFieldDisease,
              ),
              const SizedBox(height: 12),
              ValueCard(
                image: ZohImages.humidity,
                title: "Humidity",
                value: field2,
                prevValue: prevField2,
                unit: "%",
                validator: isHumidityOK,
                diseasePredictor: getFieldDisease,
              ),
              const SizedBox(height: 12),
              ValueCard(
                image: ZohImages.heartRate,
                title: "Heart Rate",
                value: field3,
                prevValue: prevField3,
                unit: "bpm",
                validator: isHeartRateOK,
                diseasePredictor: getFieldDisease,
              ),
              const SizedBox(height: 12),
              ValueCard(
                image: ZohImages.temp,
                title: "Body Temp",
                value: field4,
                prevValue: prevField4,
                unit: "°C",
                validator: isBodyTempOK,
                diseasePredictor: getFieldDisease,
              ),
              const SizedBox(height: 12),
              ValueCard(
                image: ZohImages.airQuality,
                title: "Air Quality",
                value: field5,
                prevValue: prevField5,
                unit: "AQI",
                validator: isAirQualityOK,
                diseasePredictor: getFieldDisease,
              ),
              SizedBox(height: ZohSizes.md),
              Divider(),
              SizedBox(height: ZohSizes.md),
              HealthScoreCard(
                ambient: double.parse(field1!),
                humidity: double.parse(field2!),
                bodyTemp: double.parse(field3!),
                pulse: double.parse(field4!),
                airQuality: double.parse(field5!),
              ),
              SizedBox(height: ZohSizes.md),
              HealthCard(status: healthStatus),
              const SizedBox(height: 20),
              DiseaseCard(disease: predictDisease()),
            ],
          ),
        ),
      ),
    );
  }

  void showCriticalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("🚨 Critical Alert"),
        content: const Text(
          "Abnormal health readings detected.\nImmediate veterinary attention is required.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _alertShown = false; // allow future alerts if values worsen again
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

}

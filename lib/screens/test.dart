import 'dart:async';
import 'package:flutter/material.dart';
import '../services/testing.dart';

class ThingSpeakScreens extends StatefulWidget {
  const ThingSpeakScreens({super.key});

  @override
  State<ThingSpeakScreens> createState() => _ThingSpeakScreenState();
}

class _ThingSpeakScreenState extends State<ThingSpeakScreens> {
  // Store latest & previous values
  String? latestField1, previousField1; // Ambient Temp
  String? latestField2, previousField2; // Humidity
  String? latestField3, previousField3; // Heart Rate
  String? latestField4, previousField4; // Body Temp
  String? latestField5, previousField5; // Air Quality

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadLatestData();

    // Auto refresh every 60 seconds
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _loadLatestData();
    });
  }

  String formatValue(String? value) {
    final numValue = double.tryParse(value ?? "");
    return numValue != null ? numValue.toStringAsFixed(2) : "--";
  }

  Future<void> _loadLatestData() async {
    final service = ThingSpeakService();
    final feed = await service.fetchLatestData();

    if (feed != null) {
      setState(() {
        void updateField(
          String key,
          void Function(String) updateLatest,
          void Function(String) updatePrev,
        ) {
          final newValue = feed[key]?.toString();
          if (newValue != null) {
            final old =
                {
                  "field1": latestField1,
                  "field2": latestField2,
                  "field3": latestField3,
                  "field4": latestField4,
                  "field5": latestField5,
                }[key];
            if (old != null) updatePrev(old);
            updateLatest(newValue);
          }
        }

        updateField(
          "field1",
          (v) => latestField1 = v,
          (v) => previousField1 = v,
        );
        updateField(
          "field2",
          (v) => latestField2 = v,
          (v) => previousField2 = v,
        );
        updateField(
          "field3",
          (v) => latestField3 = v,
          (v) => previousField3 = v,
        );
        updateField(
          "field4",
          (v) => latestField4 = v,
          (v) => previousField4 = v,
        );
        updateField(
          "field5",
          (v) => latestField5 = v,
          (v) => previousField5 = v,
        );
      });
    }
  }

  String detectCattleHealth({
    required String? ambTempStr,
    required String? humidityStr,
    required String? heartStr,
    required String? bodyTempStr,
    required String? airQualityStr,
  }) {
    final ambTemp = double.tryParse(ambTempStr ?? "");
    final humidity = double.tryParse(humidityStr ?? "");
    final heart = double.tryParse(heartStr ?? "");
    final bodyTemp = double.tryParse(bodyTempStr ?? "");
    final airQ = double.tryParse(airQualityStr ?? "");

    if ([ambTemp, humidity, heart, bodyTemp, airQ].contains(null)) {
      return "⚠️ Missing or invalid data";
    }

    // ✅ Healthy Range (example thresholds, adjust if needed)
    if (bodyTemp! >= 38 &&
        bodyTemp <= 39.5 &&
        heart! >= 48 &&
        heart <= 84 &&
        airQ! < 100) {
      return "✅ Normal (Healthy)";
    }

    // Body Temperature
    if (bodyTemp > 39.5)
      return "🔥 High Body Temp (${bodyTemp.toStringAsFixed(2)} °C) - Possible Fever/Infection";
    if (bodyTemp < 38)
      return "❄️ Low Body Temp (${bodyTemp.toStringAsFixed(2)} °C) - Cold Stress";

    // Heart Rate
    if (heart! > 84)
      return "💓 High Heart Rate (${heart.toStringAsFixed(2)} bpm) - Stress/Illness";
    if (heart < 48)
      return "💤 Low Heart Rate (${heart.toStringAsFixed(2)} bpm) - Weakness";

    // Ambient Temperature
    if (ambTemp! > 35)
      return "🌞 High Ambient Temp (${ambTemp.toStringAsFixed(2)} °C) - Heat Stress Risk";
    if (ambTemp < 10)
      return "🥶 Low Ambient Temp (${ambTemp.toStringAsFixed(2)} °C) - Cold Stress Risk";

    // Humidity
    if (humidity! > 80)
      return "💧 High Humidity (${humidity.toStringAsFixed(2)} %) - Risk of Disease Growth";
    if (humidity < 30)
      return "🌵 Low Humidity (${humidity.toStringAsFixed(2)} %) - Dehydration Risk";

    // Air Quality
    if (airQ! >= 100)
      return "🌬 Poor Air Quality (${airQ.toStringAsFixed(2)} AQI) - Respiratory Risk";

    return "⚠️ Unclassified Condition";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cattle Health Monitor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // _buildValueCard("🌡 Ambient Temp", latestField1, previousField1),
              // const SizedBox(height: 10),
              // _buildValueCard("💧 Humidity", latestField2, previousField2),
              // const SizedBox(height: 10),
              // _buildValueCard("💓 Heart Rate", latestField3, previousField3),
              // const SizedBox(height: 10),
              // _buildValueCard("🐄🌡 Body Temp", latestField4, previousField4),
              // const SizedBox(height: 10),
              // _buildValueCard("🌬 Air Quality", latestField5, previousField5),
              _buildValueCard("Ambient Temp", latestField1, previousField1, unit: "°C"),
              const SizedBox(height: 12),
              _buildValueCard("Humidity", latestField2, previousField2, unit: "%"),
              const SizedBox(height: 12),
              _buildValueCard("Heart Rate", latestField3, previousField3, unit: "bpm"),
              const SizedBox(height: 12),
              _buildValueCard("Body Temp", latestField4, previousField4, unit: "°C"),
              const SizedBox(height: 12),
              _buildValueCard("Air Quality Index", latestField5, previousField5, unit: "AQI"),

              const SizedBox(height: 20),
              _buildHealthCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildValueCard(String title, String? latest, String? previous) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.blue.shade50,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           latest != null
  //               ? "$title (Latest): $latest"
  //               : "$title: Waiting...",
  //           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         if (previous != null) ...[
  //           const SizedBox(height: 10),
  //           Text("Previous: $previous", style: const TextStyle(fontSize: 16)),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  Widget _buildValueCard(
    String title,
    String? latest,
    String? previous, {
    String unit = "",
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            latest != null ? "$title: ${formatValue(latest)} $unit" : "$title: Waiting...",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (previous != null) ...[
            const SizedBox(height: 10),
            Text("Previous: ${formatValue(previous)} $unit", style: const TextStyle(fontSize: 16)),
          ],
        ],
      ),
    );
  }

  Widget _buildHealthCard() {
    final status = detectCattleHealth(
      ambTempStr: latestField1,
      humidityStr: latestField2,
      heartStr: latestField3,
      bodyTempStr: latestField4,
      airQualityStr: latestField5,
    );

    // Default values
    Color bgColor = Colors.grey.shade300;
    IconData icon = Icons.warning;
    Color iconColor = Colors.black;

    if (status.contains("Healthy")) {
      bgColor = Colors.green.shade200;
      icon = Icons.check_circle;
      iconColor = Colors.green.shade900;
    } else if (status.contains("High Body Temp")) {
      bgColor = Colors.red.shade200;
      icon = Icons.local_fire_department;
      iconColor = Colors.red.shade900;
    } else if (status.contains("Low Body Temp")) {
      bgColor = Colors.blue.shade200;
      icon = Icons.ac_unit;
      iconColor = Colors.blue.shade900;
    } else if (status.contains("Heart Rate")) {
      bgColor = Colors.orange.shade200;
      icon = Icons.favorite;
      iconColor = Colors.pink.shade700;
    } else if (status.contains("Air Quality")) {
      bgColor = Colors.brown.shade200;
      icon = Icons.cloud;
      iconColor = Colors.brown.shade900;
    } else if (status.contains("Humidity")) {
      bgColor = Colors.lightBlue.shade200;
      icon = Icons.water_drop;
      iconColor = Colors.blue.shade800;
    } else if (status.contains("Ambient Temp")) {
      bgColor = Colors.orange.shade100;
      icon = Icons.wb_sunny;
      iconColor = Colors.orange.shade800;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Health Status: $status",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "🌡 Ambient Temp: ${_formatValue(latestField1)} °C\n"
            "💧 Humidity: ${_formatValue(latestField2)} %\n"
            "💓 Heart Rate: ${_formatValue(latestField3)} bpm\n"
            "🔥 Body Temp: ${_formatValue(latestField4)} °C\n"
            "🌬 Air Quality: ${_formatValue(latestField5)} AQI",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _formatValue(String? value) {
    final v = double.tryParse(value ?? "");
    return v == null ? "--" : v.toStringAsFixed(2);
  }
}

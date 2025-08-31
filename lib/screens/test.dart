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
            if (updateLatest != null && updatePrev != null) {
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

  // Health detection logic
  String detectCattleHealth({
    String? ambientStr,
    String? humidityStr,
    String? heartStr,
    String? bodyTempStr,
    String? airStr,
  }) {
    final ambient = double.tryParse(ambientStr ?? "");
    final humidity = double.tryParse(humidityStr ?? "");
    final heart = double.tryParse(heartStr ?? "");
    final bodyTemp = double.tryParse(bodyTempStr ?? "");
    final air = double.tryParse(airStr ?? "");

    if ([ambient, humidity, heart, bodyTemp].any((v) => v == null)) {
      return "⚠️ Incomplete Data";
    }

    List<String> issues = [];

    // Ambient temp
    if (ambient! < 5) issues.add("❄️ Cold Stress (Low Ambient Temp)");
    if (ambient > 25) issues.add("🔥 Heat Stress (High Ambient Temp)");

    // Humidity
    if (humidity! < 30) issues.add("💧 Low Humidity (Dehydration Risk)");
    if (humidity > 70) issues.add("🌫 High Humidity (Heat Stress Risk)");

    // Body temp
    if (bodyTemp! < 38) issues.add("❄️ Low Body Temp (Hypothermia)");
    if (bodyTemp > 39.5) issues.add("🔥 Fever / Infection");

    // Heart rate
    if (heart! < 48) issues.add("💤 Low Heart Rate (Weakness)");
    if (heart > 84) issues.add("💓 High Heart Rate (Stress)");

    // Air Quality
    if (air != null && air > 100) {
      issues.add("🌬 Poor Air Quality (Respiratory Risk)");
    }

    // Final decision
    if (issues.isEmpty) {
      return "✅ Normal (Healthy)";
    } else {
      return issues.join(" | ");
    }
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
              _buildValueCard("🌡 Ambient Temp", latestField1, previousField1),
              const SizedBox(height: 10),
              _buildValueCard("💧 Humidity", latestField2, previousField2),
              const SizedBox(height: 10),
              _buildValueCard("💓 Heart Rate", latestField3, previousField3),
              const SizedBox(height: 10),
              _buildValueCard("🐄🌡 Body Temp", latestField4, previousField4),
              const SizedBox(height: 10),
              _buildValueCard("🌬 Air Quality", latestField5, previousField5),
              const SizedBox(height: 20),
              _buildHealthCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueCard(String title, String? latest, String? previous) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            latest != null ? "$title (Latest): $latest" : "$title: Waiting...",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (previous != null) ...[
            const SizedBox(height: 10),
            Text("Previous: $previous", style: const TextStyle(fontSize: 16)),
          ],
        ],
      ),
    );
  }

  Widget _buildHealthCard() {
    final status = detectCattleHealth(
      ambientStr: latestField1,
      humidityStr: latestField2,
      heartStr: latestField3,
      bodyTempStr: latestField4,
      airStr: latestField5,
    );


    Color bgColor = Colors.grey.shade300;
    IconData icon = Icons.warning;
    Color iconColor = Colors.black;

    if (status.contains("Healthy")) {
      bgColor = Colors.green.shade200;
      icon = Icons.check_circle;
      iconColor = Colors.green.shade900;
    } else if (status.contains("Fever") || status.contains("High Body")) {
      bgColor = Colors.red.shade200;
      icon = Icons.local_fire_department;
      iconColor = Colors.red.shade900;
    } else if (status.contains("Low Body")) {
      bgColor = Colors.blue.shade100;
      icon = Icons.ac_unit;
      iconColor = Colors.blue.shade900;
    } else if (status.contains("High Heart") || status.contains("Low Heart")) {
      bgColor = Colors.orange.shade200;
      icon = Icons.favorite;
      iconColor = Colors.pink.shade700;
    } else if (status.contains("Air Quality")) {
      bgColor = Colors.brown.shade200;
      icon = Icons.air;
      iconColor = Colors.brown.shade900;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Health Status: $status",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

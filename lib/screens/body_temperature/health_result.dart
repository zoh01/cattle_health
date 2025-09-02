// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import '../../services/testing.dart';
//
// class ZohSpeakScreens extends StatefulWidget {
//   const ZohSpeakScreens({super.key});
//
//   @override
//   State<ZohSpeakScreens> createState() => _ThingSpeakScreenState();
// }
//
// class _ThingSpeakScreenState extends State<ZohSpeakScreens> {
//   String? field1, field2, field3, field4, field5; // Current values
//   String? prevField1, prevField2, prevField3, prevField4, prevField5; // Previous values
//
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLatestData();
//
//     // 🔁 Auto refresh every 60s
//     _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
//       _loadLatestData();
//     });
//   }
//
//   Future<void> _loadLatestData() async {
//     final service = ThingSpeakService();
//     final feed = await service.fetchLatestData();
//
//     if (feed != null) {
//       setState(() {
//         // Save previous before updating
//         prevField1 = field1;
//         prevField2 = field2;
//         prevField3 = field3;
//         prevField4 = field4;
//         prevField5 = field5;
//
//         // Update latest values
//         field1 = _formatValue(feed["field1"]);
//         field2 = _formatValue(feed["field2"]);
//         field3 = _formatValue(feed["field3"]);
//         field4 = _formatValue(feed["field4"]);
//         field5 = _formatValue(feed["field5"]);
//       });
//     }
//   }
//
//   String? _formatValue(dynamic value) {
//     if (value == null) return null;
//     final num? parsed = num.tryParse(value.toString());
//     return parsed != null ? parsed.toStringAsFixed(2) : value.toString();
//   }
//
//   // ✅ Normal ranges
//   bool isAmbientTempOK(double val) => val >= 15 && val <= 30;
//   bool isHumidityOK(double val) => val >= 40 && val <= 70;
//   bool isHeartRateOK(double val) => val >= 48 && val <= 84;
//   bool isBodyTempOK(double val) => val >= 38 && val <= 39.5;
//   bool isAirQualityOK(double val) => val <= 100;
//
//   // 🔎 Detect cattle health status
//   String detectCattleHealth() {
//     final tempAmb = double.tryParse(field1 ?? "");
//     final humidity = double.tryParse(field2 ?? "");
//     final heart = double.tryParse(field3 ?? "");
//     final tempBody = double.tryParse(field4 ?? "");
//     final airQ = double.tryParse(field5 ?? "");
//
//     if ([tempAmb, humidity, heart, tempBody, airQ].contains(null)) {
//       return "⚠️ Not enough data to predict health";
//     }
//
//     bool ambOK = isAmbientTempOK(tempAmb!);
//     bool humOK = isHumidityOK(humidity!);
//     bool heartOK = isHeartRateOK(heart!);
//     bool bodyOK = isBodyTempOK(tempBody!);
//     bool airOK = isAirQualityOK(airQ!);
//
//     if (ambOK && humOK && heartOK && bodyOK && airOK) {
//       return "✅ Healthy (All vitals normal)";
//     }
//
//     List<String> issues = [];
//     if (!ambOK) issues.add(tempAmb > 30 ? "High Ambient Temp" : "Low Ambient Temp");
//     if (!humOK) issues.add(humidity > 70 ? "High Humidity" : "Low Humidity");
//     if (!heartOK) issues.add(heart > 84 ? "High Heart Rate" : "Low Heart Rate");
//     if (!bodyOK) issues.add(tempBody > 39.5 ? "High Body Temp" : "Low Body Temp");
//     if (!airOK) issues.add("Poor Air Quality");
//
//     return "⚠️ Issues: ${issues.join(', ')}";
//   }
//
//   // 🔮 Predict possible disease based on abnormal patterns
//   String predictDisease() {
//     final tempAmb = double.tryParse(field1 ?? "");
//     final humidity = double.tryParse(field2 ?? "");
//     final heart = double.tryParse(field3 ?? "");
//     final tempBody = double.tryParse(field4 ?? "");
//     final airQ = double.tryParse(field5 ?? "");
//
//     if ([tempAmb, humidity, heart, tempBody, airQ].contains(null)) {
//       return "⚠️ Not enough data for disease prediction";
//     }
//
//     List<String> diseases = [];
//
//     // Fever / Infection
//     if (tempBody! > 39.5 && heart! > 84) {
//       diseases.add("Fever / Infection");
//     }
//
//     // Hypothermia
//     if (tempBody < 38 && heart! < 48) {
//       diseases.add("Hypothermia");
//     }
//
//     // Heat Stress
//     if (tempAmb! > 30 && humidity! > 70) {
//       diseases.add("Heat Stress");
//     }
//
//     // Respiratory Issues
//     if (airQ! > 100 && heart! > 84) {
//       diseases.add("Respiratory Issues");
//     }
//
//     if (diseases.isEmpty) {
//       return "✅ No specific disease detected. Just monitor cattle.";
//     }
//
//     return "🩺 Possible Disease(s): ${diseases.join(', ')}";
//   }
//
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final healthStatus = detectCattleHealth();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("ThingSpeak Cattle Health")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildValueCard("Ambient Temp", field1, prevField1, "°C", isAmbientTempOK),
//               const SizedBox(height: 12),
//               _buildValueCard("Humidity", field2, prevField2, "%", isHumidityOK),
//               const SizedBox(height: 12),
//               _buildValueCard("Heart Rate", field3, prevField3, "bpm", isHeartRateOK),
//               const SizedBox(height: 12),
//               _buildValueCard("Body Temp", field4, prevField4, "°C", isBodyTempOK),
//               const SizedBox(height: 12),
//               _buildValueCard("Air Quality Index", field5, prevField5, "AQI", isAirQualityOK),
//               const SizedBox(height: 30),
//               _buildHealthCard(healthStatus),
//               const SizedBox(height: 20),
//               _buildDiseaseCard(predictDisease()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildValueCard(
//       String title, String? value, String? prevValue, String unit, bool Function(double) validator) {
//     Color bgColor = Colors.grey.shade300;
//
//     if (value != null) {
//       final double? val = double.tryParse(value);
//       if (val != null) {
//         if (validator(val)) {
//           bgColor = Colors.green.shade200; // ✅ Normal
//         } else {
//           bgColor = Colors.red.shade200; // ❌ Abnormal
//         }
//       }
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             value != null ? "$title: $value $unit" : "$title: Waiting...",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           if (prevValue != null)
//             Text(
//               "Previous: $prevValue $unit",
//               style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//             ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildHealthCard(String status) {
//     Color bgColor = Colors.grey.shade300;
//     IconData icon = Icons.warning;
//     Color iconColor = Colors.black;
//
//     if (status.contains("Healthy")) {
//       bgColor = Colors.green.shade200;
//       icon = Icons.check_circle;
//       iconColor = Colors.green.shade900;
//     } else if (status.contains("Issues")) {
//       bgColor = Colors.orange.shade200;
//       icon = Icons.report_problem;
//       iconColor = Colors.orange.shade900;
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 32, color: iconColor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               "Overall Health Status:\n$status",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDiseaseCard(String disease) {
//     Color bgColor = Colors.blue.shade200;
//     IconData icon = Icons.healing;
//     Color iconColor = Colors.blue.shade900;
//
//     if (disease.contains("No specific disease")) {
//       bgColor = Colors.green.shade200;
//       icon = Icons.check_circle;
//       iconColor = Colors.green.shade900;
//     } else if (disease.contains("Possible")) {
//       bgColor = Colors.red.shade200;
//       icon = Icons.local_hospital;
//       iconColor = Colors.red.shade900;
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 32, color: iconColor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               "Disease Prediction:\n$disease",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }

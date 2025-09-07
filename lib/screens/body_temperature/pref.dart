// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../services/testing.dart';
// import 'package:cattle_health/utils/constants/image_string.dart';
// import 'package:cattle_health/utils/constants/sizes.dart';
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
//   Timer? _timer;
//   String? _lastEntryId;
//
//   /// Notifications
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initNotifications();
//     _checkForNewData(); // First load
//     _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
//       _checkForNewData();
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   /// Initialize notifications
//   Future<void> _initNotifications() async {
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(android: androidInit);
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }
//
//   /// Trigger a notification
//   Future<void> _showHealthAlert(String message) async {
//     const androidDetails = AndroidNotificationDetails(
//       'health_channel',
//       'Cattle Health Alerts',
//       channelDescription: 'Alerts for abnormal cattle vitals',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     const notificationDetails = NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       '🚨 Cattle Health Alert',
//       message,
//       notificationDetails,
//     );
//   }
//
//   /// Fetch latest data from ThingSpeak
//   Future<void> _checkForNewData() async {
//     final service = ThingSpeakService();
//     final feed = await service.fetchLatestData();
//
//     if (feed != null) {
//       final String? newEntryId = feed["entry_id"]?.toString();
//
//       if (newEntryId != null && newEntryId != _lastEntryId) {
//         _lastEntryId = newEntryId;
//         _updateValues(feed);
//
//         // After updating, check health and notify if abnormal
//         final healthStatus = detectCattleHealth();
//         if (healthStatus.contains("Issues")) {
//           _showHealthAlert(healthStatus);
//         }
//       }
//     }
//   }
//
//   /// Update and save previous values
//   void _updateValues(Map<String, dynamic> feed) {
//     setState(() {
//       prevField1 = field1;
//       prevField2 = field2;
//       prevField3 = field3;
//       prevField4 = field4;
//       prevField5 = field5;
//
//       field1 = _formatValue(feed["field1"]);
//       field2 = _formatValue(feed["field2"]);
//       field3 = _formatValue(feed["field3"]);
//       field4 = _formatValue(feed["field4"]);
//       field5 = _formatValue(feed["field5"]);
//     });
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
//     return "Issues: ${issues.join(', ')}";
//   }
//
//   // 🔮 Predict possible disease
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
//     if (tempBody! > 39.5 && heart! > 84) diseases.add("Fever / Infection");
//     if (tempBody < 38 && heart! < 48) diseases.add("Hypothermia");
//     if (tempAmb! > 30 && humidity! > 70) diseases.add("Heat Stress");
//     if (airQ! > 100 && heart! > 84) diseases.add("Respiratory Issues");
//
//     return diseases.isEmpty
//         ? "✅ No specific disease detected. Just monitor cattle."
//         : "Possible Disease(s): ${diseases.join(', ')}";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final healthStatus = detectCattleHealth();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("ThingSpeak Cattle Health")),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(ZohSizes.md),
//           child: Column(
//             children: [
//               _buildValueCard(ZohImages.ambientTemp, "Ambient Temp", field1, prevField1, "°C", isAmbientTempOK),
//               const SizedBox(height: 12),
//               _buildValueCard(ZohImages.humidity, "Humidity", field2, prevField2, "%", isHumidityOK),
//               const SizedBox(height: 12),
//               _buildValueCard(ZohImages.heartRate, "Heart Rate", field3, prevField3, "bpm", isHeartRateOK),
//               const SizedBox(height: 12),
//               _buildValueCard(ZohImages.temp, "Body Temp", field4, prevField4, "°C", isBodyTempOK),
//               const SizedBox(height: 12),
//               _buildValueCard(ZohImages.airQuality, "Air Quality Index", field5, prevField5, "AQI", isAirQualityOK),
//               SizedBox(height: ZohSizes.md),
//               Divider(),
//               SizedBox(height: ZohSizes.md),
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
//   /// Value Card
//   Widget _buildValueCard(
//       String image,
//       String title,
//       String? value,
//       String? prevValue,
//       String unit,
//       bool Function(double) validator,
//       ) {
//     Color bgColor = Colors.grey.shade300;
//     if (value != null) {
//       final double? val = double.tryParse(value);
//       if (val != null) {
//         bgColor = validator(val) ? Colors.green.shade400 : Colors.red.shade400;
//       }
//     }
//     return Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(ZohSizes.md),
//         width: double.infinity,
//         decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 color: Colors.grey.shade300,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(ZohSizes.md),
//                 child: Image(image: AssetImage(image), fit: BoxFit.contain, height: 70, width: 60),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(title),
//                 Text(value != null ? "$value $unit" : "Pending..."),
//                 if (value != null && prevValue != null)
//                   Text("Previous: $prevValue $unit",
//                       style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Health Status Card
//   Widget _buildHealthCard(String status) {
//     Color bgColor = Colors.grey.shade300;
//     String healthImage = ZohImages.report;
//     if (status.contains("Healthy")) {
//       bgColor = Colors.green.shade400;
//       healthImage = ZohImages.check;
//     } else if (status.contains("Issues")) {
//       bgColor = Colors.red.shade400;
//       healthImage = ZohImages.report;
//     }
//
//     return Material(
//       borderRadius: BorderRadius.circular(ZohSizes.md),
//       elevation: 5,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(ZohSizes.md),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(ZohSizes.md), color: bgColor),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(ZohSizes.md), color: Colors.grey.shade400),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image(image: AssetImage(healthImage), height: 70, width: 60, fit: BoxFit.contain),
//                 ),
//               ),
//             ),
//             SizedBox(width: ZohSizes.defaultSpace),
//             Expanded(
//               flex: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Overall Health Status",
//                       style: TextStyle(fontSize: ZohSizes.defaultSpace, fontWeight: FontWeight.bold)),
//                   Text(status, style: TextStyle(fontSize: ZohSizes.md, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Disease Card
//   Widget _buildDiseaseCard(String disease) {
//     Color bgColor = Colors.blue.shade300;
//     String diseaseImage = ZohImages.healing;
//     if (disease.contains("No specific disease")) {
//       bgColor = Colors.green.shade300;
//       diseaseImage = ZohImages.check;
//     } else if (disease.contains("Possible")) {
//       bgColor = Colors.red.shade300;
//       diseaseImage = ZohImages.hospital;
//     }
//
//     return Material(
//       borderRadius: BorderRadius.circular(ZohSizes.md),
//       elevation: 5,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(ZohSizes.md),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(ZohSizes.md), color: bgColor),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(ZohSizes.md), color: Colors.grey.shade400),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image(image: AssetImage(diseaseImage), height: 70, width: 60, fit: BoxFit.contain),
//                 ),
//               ),
//             ),
//             SizedBox(width: ZohSizes.defaultSpace),
//             Expanded(
//               flex: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Disease Prediction",
//                       style: TextStyle(fontSize: ZohSizes.defaultSpace, fontWeight: FontWeight.bold)),
//                   Text(disease, style: TextStyle(fontSize: ZohSizes.md, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

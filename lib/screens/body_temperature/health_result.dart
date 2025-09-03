// import 'package:cattle_health/utils/constants/image_string.dart';
// import 'package:cattle_health/utils/constants/sizes.dart';
// import 'package:cattle_health/utils/helper_function/helper_functions.dart';
// import 'package:flutter/material.dart';
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
//   String? prevField1,
//       prevField2,
//       prevField3,
//       prevField4,
//       prevField5; // Previous values
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLatestData(); // Load once on startup
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
//
//   bool isHumidityOK(double val) => val >= 40 && val <= 70;
//
//   bool isHeartRateOK(double val) => val >= 48 && val <= 84;
//
//   bool isBodyTempOK(double val) => val >= 38 && val <= 39.5;
//
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
//     if (!ambOK) {
//       issues.add(tempAmb > 30 ? "High Ambient Temp" : "Low Ambient Temp");
//     }
//     if (!humOK) issues.add(humidity > 70 ? "High Humidity" : "Low Humidity");
//     if (!heartOK) issues.add(heart > 84 ? "High Heart Rate" : "Low Heart Rate");
//     if (!bodyOK) {
//       issues.add(tempBody > 39.5 ? "High Body Temp" : "Low Body Temp");
//     }
//     if (!airOK) issues.add("Poor Air Quality");
//
//     return "Issues: ${issues.join(', ')}";
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
//     if (tempBody! > 39.5 && heart! > 84) {
//       diseases.add("Fever / Infection");
//     }
//     if (tempBody < 38 && heart! < 48) {
//       diseases.add("Hypothermia");
//     }
//     if (tempAmb! > 30 && humidity! > 70) {
//       diseases.add("Heat Stress");
//     }
//     if (airQ! > 100 && heart! > 84) {
//       diseases.add("Respiratory Issues");
//     }
//
//     if (diseases.isEmpty) {
//       return "✅ No specific disease detected. Just monitor cattle.";
//     }
//
//     return "Possible Disease(s): ${diseases.join(', ')}";
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
//               _buildValueCard(
//                 ZohImages.ambientTemp,
//                 "Ambient Temp",
//                 field1,
//                 prevField1,
//                 "°C",
//                 isAmbientTempOK,
//               ),
//               const SizedBox(height: 12),
//               _buildValueCard(
//                 ZohImages.humidity,
//                 "Humidity",
//                 field2,
//                 prevField2,
//                 "%",
//                 isHumidityOK,
//               ),
//               const SizedBox(height: 12),
//               _buildValueCard(
//                 ZohImages.heartRate,
//                 "Heart Rate",
//                 field3,
//                 prevField3,
//                 "bpm",
//                 isHeartRateOK,
//               ),
//               const SizedBox(height: 12),
//               _buildValueCard(
//                 ZohImages.temp,
//                 "Body Temp",
//                 field4,
//                 prevField4,
//                 "°C",
//                 isBodyTempOK,
//               ),
//               const SizedBox(height: 12),
//               _buildValueCard(
//                 ZohImages.airQuality,
//                 "Air Quality Index",
//                 field5,
//                 prevField5,
//                 "AQI",
//                 isAirQualityOK,
//               ),
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
//   Widget _buildValueCard(
//       String image,
//       String title,
//       String? value,
//       String? prevValue,
//       String unit,
//       bool Function(double) validator,
//       ) {
//     Color bgColor = Colors.grey.shade300;
//
//     if (value != null) {
//       final double? val = double.tryParse(value);
//       if (val != null) {
//         if (validator(val)) {
//           bgColor = Colors.green.shade400;
//         } else {
//           bgColor = Colors.red.shade400;
//         }
//       }
//     }
//
//     return Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(ZohSizes.md),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
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
//                 child: Image(
//                   image: AssetImage(image),
//                   fit: BoxFit.contain,
//                   height: 70,
//                   width: 60,
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(title),
//                     Text(value != null ? "$value $unit" : "Pending..."),
//                   ],
//                 ),
//
//                 if (value != null &&
//                     prevValue != null) // show prev only if latest exists
//                   Text(
//                     "Previous: $prevValue $unit",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Overall Health Status Card
//   Widget _buildHealthCard(String status) {
//     Color bgColor = Colors.grey.shade300;
//     String healthImage = ZohImages.report;
//
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
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(ZohSizes.md),
//           color: bgColor,
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(ZohSizes.md),
//                   color: Colors.grey.shade400,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image(
//                     image: AssetImage(healthImage),
//                     height: 70,
//                     width: 60,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: ZohSizes.defaultSpace),
//             Expanded(
//               flex: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Overall Health Status",
//                     style: TextStyle(
//                       fontSize: ZohSizes.defaultSpace,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Roboto",
//                     ),
//                   ),
//                   Text(status, style: TextStyle(fontSize: ZohSizes.md, fontFamily: "Inter", fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   /// Disease Card
//   Widget _buildDiseaseCard(String disease) {
//     Color bgColor = Colors.blue.shade300;
//     String diseaseImage = ZohImages.healing;
//
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
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(ZohSizes.md),
//           color: bgColor,
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(ZohSizes.md),
//                   color: Colors.grey.shade400,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image(
//                     image: AssetImage(diseaseImage),
//                     height: 70,
//                     width: 60,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: ZohSizes.defaultSpace),
//             Expanded(
//               flex: 6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Disease Prediction",
//                     style: TextStyle(
//                       fontSize: ZohSizes.defaultSpace,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Roboto",
//                     ),
//                   ),
//                   Text(disease, style: TextStyle(fontSize: ZohSizes.md, fontFamily: "Inter", fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

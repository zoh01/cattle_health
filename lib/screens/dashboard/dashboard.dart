// import 'dart:convert';
//
// import 'package:cattle_health/models/feeds_models.dart';
// import 'package:cattle_health/screens/login_screen/login.dart';
// import 'package:cattle_health/services/heart_rate.dart';
// import 'package:cattle_health/utils/constants/colors.dart';
// import 'package:cattle_health/utils/constants/image_string.dart';
// import 'package:cattle_health/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   // List<FeedsModel> feeds = [];
//   // bool loading = true;
//
//   // getHeart() async {
//   //   HeartRate heartClass = HeartRate();
//   //   await heartClass.getHeart();
//   //   feeds = heartClass.heart;
//   //   setState(() {
//   //     loading = false;
//   //   });
//   // }
//
//   Future<Album> fetchAlbum() async {
//     final response = await http.get(Uri.parse('https://api.thingspeak.com/channels/2769547/fields/3.json?api_key=CLC2P68LXMZ7KDN4&results=1'));
//
//     if(response.statusCode == 200){
//       return Album.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Failed to load API");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Health Dashboard", style: TextStyle(color: Colors.white)),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: ZohColors.secondaryColor,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: ZohSizes.sm),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Login()),
//                 );
//               },
//               icon: Icon(Icons.logout, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(ZohSizes.defaultSpace),
//           child: Column(
//             children: [
//             Material(
//             elevation: 4,
//             borderRadius: BorderRadius.circular(ZohSizes.md),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 color: Colors.white,
//                 border: Border.all(color: Colors.white),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(
//                           ZohSizes.md,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(ZohSizes.md),
//                         child: Image(
//                           image: AssetImage(ZohImages.heartRate),
//                           height: 90,
//                           width: 70,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(ZohSizes.md),
//                       child: Column(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             'Heart Rate',
//                             style: TextStyle(
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.bold,
//                               fontSize: ZohSizes.spaceBtwItems,
//                             ),
//                           ),
//                           Text(
//                             'War',
//                             style: TextStyle(
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.bold,
//                               fontSize: ZohSizes.spaceBtwItems,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//               SizedBox(height: ZohSizes.spaceBtwZoh),
//               Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(ZohSizes.md),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(ZohSizes.md),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(ZohSizes.md),
//                             child: Image(
//                               image: AssetImage(ZohImages.temp),
//                               height: 90,
//                               width: 70,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(ZohSizes.md),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Temperature',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                               Text(
//                                 '27.6 \u00B0C',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: ZohSizes.spaceBtwZoh),
//               Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(ZohSizes.md),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(ZohSizes.md),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(ZohSizes.md),
//                             child: Image(
//                               image: AssetImage(ZohImages.humidity),
//                               height: 90,
//                               width: 70,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(ZohSizes.md),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Humidity',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                               Text(
//                                 '69 %',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: ZohSizes.spaceBtwZoh),
//               Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(ZohSizes.md),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(ZohSizes.md),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(ZohSizes.md),
//                             child: Image(
//                               image: AssetImage(ZohImages.ambientTemp),
//                               height: 90,
//                               width: 70,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(ZohSizes.md),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Ambient Temperature',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                               Text(
//                                 '24.9 \u00B0C',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                                 textAlign: TextAlign.end,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: ZohSizes.spaceBtwZoh),
//               Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(ZohSizes.md),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(ZohSizes.md),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(ZohSizes.md),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(ZohSizes.md),
//                             child: Image(
//                               image: AssetImage(ZohImages.airQuality),
//                               height: 90,
//                               width: 70,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(ZohSizes.md),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Air Quality',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                               Text(
//                                 '75 %',
//                                 style: TextStyle(
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: ZohSizes.spaceBtwItems,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               ElevatedButton(onPressed: () {
//                 fetchAlbum().then((value) {
//                   print(value.field3);
//                 });
//               }, child: Text('Wariz'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Album {
//   final int entry_id;
//   final String field3;
//
//   Album({required this.entry_id, required this.field3});
//
//   factory Album.fromJson(Map<String,dynamic> json) {
//     return Album(entry_id: json['entry_id'], field3: json['entry_id']);
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/thingspeak.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';

class ThingSpeakScreen extends StatefulWidget {
  const ThingSpeakScreen({Key? key}) : super(key: key);

  @override
  State<ThingSpeakScreen> createState() => _ThingSpeakScreenState();
}

class _ThingSpeakScreenState extends State<ThingSpeakScreen> {
  // String? latestValue;
  // String? lastEntryId;
  // List<String> history = [];
  // Timer? _timer;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _checkForNewData();
  //
  //   // 🔁 Poll API every 5 seconds
  //   _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
  //     _checkForNewData();
  //   });
  // }
  //
  // Future<void> _checkForNewData() async {
  //   final service = ThingSpeakService();
  //   final feed = await service.fetchLatestFeed();
  //
  //   if (feed != null) {
  //     final newEntryId = feed["entry_id"].toString();
  //     final newValue = feed["field4"].toString();
  //
  //     if (lastEntryId != newEntryId) {
  //       // ✅ New data arrived
  //       setState(() {
  //         lastEntryId = newEntryId;
  //         latestValue = newValue;
  //         history.insert(0, newValue); // keep newest at top
  //       });
  //     }
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   _timer?.cancel(); // stop polling when screen closes
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ThingSpeak Auto Refresh (New Data)")),
      body: Column(children: [BodyTemp(),
      BodyTemp()]),
    );
  }
}

class BodyTemp extends StatefulWidget {
  const BodyTemp({super.key});

  @override
  State<BodyTemp> createState() => _BodyTempState();
}

class _BodyTempState extends State<BodyTemp> {
  String? latestValue;
  String? lastEntryId;
  List<String> history = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkForNewData();

    // 🔁 Poll API every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _checkForNewData();
    });
  }

  Future<void> _checkForNewData() async {
    final service = ThingSpeakService();
    final feed = await service.fetchLatestFeed();

    if (feed != null) {
      final newEntryId = feed["entry_id"].toString();
      final newValue = feed["field4"].toString();

      if (lastEntryId != newEntryId) {
        // ✅ New data arrived
        setState(() {
          lastEntryId = newEntryId;
          latestValue = newValue;
          history.insert(0, newValue); // keep newest at top
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // stop polling when screen closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(ZohSizes.md),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ZohSizes.md),
          color: Colors.white,
          border: Border.all(color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(
                        ZohSizes.md,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(ZohSizes.md),
                      child: Image(
                        image: AssetImage(ZohImages.heartRate),
                        height: 90,
                        width: 70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(ZohSizes.md),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Present Heart Rate',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: ZohSizes.spaceBtwItems,
                          ),
                        ),
                        Text(
                          latestValue != null ? "$latestValue B/M" : "Waiting",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: ZohSizes.spaceBtwItems,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

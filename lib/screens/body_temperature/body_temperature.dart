import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/thingspeak.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';

class BodyTemperature extends StatefulWidget {
  const BodyTemperature({super.key});

  @override
  State<BodyTemperature> createState() => _BodyTemperatureState();
}

class _BodyTemperatureState extends State<BodyTemperature> {
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
    return Scaffold(
      body: Column(
        children: [
        Material(
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
                child: Row(
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
              ),
            ),
          ),
        Material(
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
                child: Row(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

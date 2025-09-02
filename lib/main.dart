import 'package:cattle_health/screens/body_temperature/body_temperature.dart';
import 'package:cattle_health/screens/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ZohSpeakScreens(),
    );
  }
}


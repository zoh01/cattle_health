// lib/screens/dashboard/cattle_monitor_screen.dart

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../models/alert/alert_dialog.dart';
import '../../models/shimmer/shimmer_loader.dart';
import '../../services/api_data.dart';
import '../../services/cattle_health_service.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';
import '../dashboard/widgets/disease_card.dart';
import '../dashboard/widgets/health_card.dart';
import '../dashboard/widgets/health_score_card.dart';
import '../dashboard/widgets/value_card.dart';

class CattleMonitorScreen extends StatefulWidget {
  const CattleMonitorScreen({super.key});

  @override
  State<CattleMonitorScreen> createState() => _CattleMonitorScreenState();
}

class _CattleMonitorScreenState extends State<CattleMonitorScreen> {
  // Services
  final ThingSpeakService _thingSpeakService = ThingSpeakService();
  final CattleHealthService _healthService = CattleHealthService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // State variables
  String? field1, field2, field3, field4, field5;
  String? prevField1, prevField2, prevField3, prevField4, prevField5;
  String? _lastEntryId;
  Timer? _timer;
  bool _alertShown = false;

  @override
  void initState() {
    super.initState();
    _loadLatestData();
    _startPolling();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      _checkForNewData();
    });
  }

  Future<void> _loadLatestData() async {
    final feed = await _thingSpeakService.fetchLatestData();
    if (feed != null) {
      _lastEntryId = feed["entry_id"]?.toString();
      _updateValues(feed);
    }
  }

  Future<void> _checkForNewData() async {
    final feed = await _thingSpeakService.fetchLatestData();
    if (feed != null) {
      final String? newEntryId = feed["entry_id"]?.toString();
      if (newEntryId != null && newEntryId != _lastEntryId) {
        _lastEntryId = newEntryId;
        _updateValues(feed);
      }
    }
  }

  void _updateValues(Map<String, dynamic> feed) {
    setState(() {
      // Save previous values
      prevField1 = field1;
      prevField2 = field2;
      prevField3 = field3;
      prevField4 = field4;
      prevField5 = field5;

      // Update current values
      field1 = _formatValue(feed["field1"]);
      field2 = _formatValue(feed["field2"]);
      field3 = _formatValue(feed["field3"]);
      field4 = _formatValue(feed["field4"]);
      field5 = _formatValue(feed["field5"]);
    });

    _checkHealthStatus();
  }

  void _checkHealthStatus() {
    final readings = CattleHealthReadings(
      ambientTemp: double.tryParse(field1 ?? ""),
      humidity: double.tryParse(field2 ?? ""),
      heartRate: double.tryParse(field3 ?? ""),
      bodyTemp: double.tryParse(field4 ?? ""),
      airQuality: double.tryParse(field5 ?? ""),
    );

    if (_healthService.isCritical(readings)) {
      _showCriticalAlert();
    }
  }

  Future<void> _showCriticalAlert() async {
    if (_alertShown) return;
    _alertShown = true;

    await _audioPlayer.play(AssetSource('sounds/alert.mp3'), volume: 1.0);

    if (!mounted) return;

    await showCriticalAlertDialog(
      context: context,
      onDismiss: () => _alertShown = false,
      onViewDetails: () {
        _alertShown = false;
        // Navigate to details screen
      },
    );
  }

  String? _formatValue(dynamic value) {
    if (value == null) return null;
    final num? parsed = num.tryParse(value.toString());
    return parsed != null ? parsed.toStringAsFixed(2) : value.toString();
  }

  bool _hasAllData() {
    return field1 != null &&
        field2 != null &&
        field3 != null &&
        field4 != null &&
        field5 != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: _buildAppBar(),
      body: _hasAllData() ? _buildContent() : _buildLoading(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildLoading() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ShimmerLoader(height: 150),
            ShimmerLoader(height: 150),
            ShimmerLoader(height: 150),
            ShimmerLoader(height: 150),
            ShimmerLoader(height: 150),
            SizedBox(height: 20),
            ShimmerLoader(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final readings = CattleHealthReadings(
      ambientTemp: double.parse(field1!),
      humidity: double.parse(field2!),
      heartRate: double.parse(field3!),
      bodyTemp: double.parse(field4!),
      airQuality: double.parse(field5!),
    );

    final healthStatus = _healthService.detectHealth(readings);
    final diseasePrediction = _healthService.predictDisease(readings);

    return SingleChildScrollView(
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
              validator: _healthService.validators.isAmbientTempOK,
              diseasePredictor: _healthService.getFieldDisease,
            ),
            const SizedBox(height: 12),
            ValueCard(
              image: ZohImages.humidity,
              title: "Humidity",
              value: field2,
              prevValue: prevField2,
              unit: "%",
              validator: _healthService.validators.isHumidityOK,
              diseasePredictor: _healthService.getFieldDisease,
            ),
            const SizedBox(height: 12),
            ValueCard(
              image: ZohImages.heartRate,
              title: "Heart Rate",
              value: field3,
              prevValue: prevField3,
              unit: "bpm",
              validator: _healthService.validators.isHeartRateOK,
              diseasePredictor: _healthService.getFieldDisease,
            ),
            const SizedBox(height: 12),
            ValueCard(
              image: ZohImages.temp,
              title: "Body Temp",
              value: field4,
              prevValue: prevField4,
              unit: "°C",
              validator: _healthService.validators.isBodyTempOK,
              diseasePredictor: _healthService.getFieldDisease,
            ),
            const SizedBox(height: 12),
            ValueCard(
              image: ZohImages.airQuality,
              title: "Air Quality",
              value: field5,
              prevValue: prevField5,
              unit: "AQI",
              validator: _healthService.validators.isAirQualityOK,
              diseasePredictor: _healthService.getFieldDisease,
            ),
            const SizedBox(height: ZohSizes.md),
            const Divider(),
            const SizedBox(height: ZohSizes.md),
            HealthScoreCard(
              ambient: readings.ambientTemp!,
              humidity: readings.humidity!,
              bodyTemp: readings.bodyTemp!,
              pulse: readings.heartRate!,
              airQuality: readings.airQuality!,
            ),
            const SizedBox(height: ZohSizes.md),
            HealthCard(status: healthStatus),
            const SizedBox(height: 20),
            DiseaseCard(disease: diseasePrediction),
          ],
        ),
      ),
    );
  }
}
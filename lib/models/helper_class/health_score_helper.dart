import 'package:flutter/material.dart';

/// ------------------------
/// SENSOR NORMALIZATION
/// ------------------------

double normalizeAmbientTemp(double temp) {
  if (temp < 18 || temp > 30) return 20;
  if (temp >= 24 && temp <= 28) return 100;
  return 70;
}

double normalizeHumidity(double hum) {
  if (hum < 40 || hum > 80) return 20;
  if (hum >= 50 && hum <= 70) return 100;
  return 70;
}

double normalizeBodyTemp(double temp) {
  if (temp < 35 || temp > 41) return 10;
  if (temp >= 37.5 && temp <= 39) return 100;
  return 60;
}

double normalizePulseRate(double pulse) {
  if (pulse < 40 || pulse > 120) return 10;
  if (pulse >= 55 && pulse <= 80) return 100;
  return 60;
}

double normalizeAirQuality(double value) {
  if (value > 300) return 10;
  if (value <= 100) return 100;
  return 60;
}

/// ------------------------
/// HEALTH SCORE FORMULA
/// ------------------------

double computeHealthScore({
  required double ambientTemp,
  required double humidity,
  required double bodyTemp,
  required double pulseRate,
  required double airQuality,
}) {
  final ambientScore = normalizeAmbientTemp(ambientTemp);
  final humidityScore = normalizeHumidity(humidity);
  final bodyTempScore = normalizeBodyTemp(bodyTemp);
  final pulseScore = normalizePulseRate(pulseRate);
  final airScore = normalizeAirQuality(airQuality);

  return (ambientScore * 0.15) +
      (humidityScore * 0.15) +
      (bodyTempScore * 0.30) +
      (pulseScore * 0.25) +
      (airScore * 0.15);
}

/// ------------------------
/// CATEGORY & COLOR
/// ------------------------

String getHealthCategory(double score) {
  if (score >= 90) return "Excellent";
  if (score >= 70) return "Good";
  if (score >= 50) return "Fair";
  if (score >= 30) return "Poor";
  return "Critical";
}

Color getHealthColor(double score) {
  if (score >= 90) return Colors.purple;
  if (score >= 70) return Colors.green;
  if (score >= 50) return Colors.yellow.shade700;
  if (score >= 30) return Colors.orange;
  return Colors.red;
}
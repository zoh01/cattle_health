// lib/utils/validators/health_validators.dart

class HealthValidators {
  /// Normal range: 15°C - 30°C
  bool isAmbientTempOK(double value) => value >= 15 && value <= 30;

  /// Normal range: 40% - 70%
  bool isHumidityOK(double value) => value >= 40 && value <= 70;

  /// Normal range: 48 - 84 bpm
  bool isHeartRateOK(double value) => value >= 48 && value <= 84;

  /// Normal range: 38°C - 39.5°C
  bool isBodyTempOK(double value) => value >= 38 && value <= 39.5;

  /// Normal range: 0 - 100 AQI
  bool isAirQualityOK(double value) => value <= 100;
}
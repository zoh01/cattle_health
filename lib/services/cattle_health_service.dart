// lib/services/cattle_health_service.dart
import 'health_validator.dart';

class CattleHealthReadings {
  final double? ambientTemp;
  final double? humidity;
  final double? heartRate;
  final double? bodyTemp;
  final double? airQuality;

  CattleHealthReadings({
    this.ambientTemp,
    this.humidity,
    this.heartRate,
    this.bodyTemp,
    this.airQuality,
  });

  bool get hasAllData {
    return ambientTemp != null &&
        humidity != null &&
        heartRate != null &&
        bodyTemp != null &&
        airQuality != null;
  }
}

class CattleHealthService {
  final HealthValidators validators = HealthValidators();

  /// Detect overall cattle health status
  String detectHealth(CattleHealthReadings readings) {
    if (!readings.hasAllData) {
      return "⚠️ Not enough data to predict health";
    }

    final bool ambOK = validators.isAmbientTempOK(readings.ambientTemp!);
    final bool humOK = validators.isHumidityOK(readings.humidity!);
    final bool heartOK = validators.isHeartRateOK(readings.heartRate!);
    final bool bodyOK = validators.isBodyTempOK(readings.bodyTemp!);
    final bool airOK = validators.isAirQualityOK(readings.airQuality!);

    if (ambOK && humOK && heartOK && bodyOK && airOK) {
      return "✅ Healthy (All vitals normal)";
    }

    List<String> issues = [];
    if (!ambOK) {
      issues.add(readings.ambientTemp! > 30
          ? "High Ambient Temp"
          : "Low Ambient Temp");
    }
    if (!humOK) {
      issues.add(readings.humidity! > 70
          ? "High Humidity"
          : "Low Humidity");
    }
    if (!heartOK) {
      issues.add(readings.heartRate! > 84
          ? "High Heart Rate"
          : "Low Heart Rate");
    }
    if (!bodyOK) {
      issues.add(readings.bodyTemp! > 39.5
          ? "High Body Temp"
          : "Low Body Temp");
    }
    if (!airOK) {
      issues.add("Poor Air Quality");
    }

    return "Issues: ${issues.join(', ')}";
  }

  /// Check if readings are critical
  bool isCritical(CattleHealthReadings readings) {
    if (!readings.hasAllData) return false;

    return !validators.isAmbientTempOK(readings.ambientTemp!) ||
        !validators.isHumidityOK(readings.humidity!) ||
        !validators.isHeartRateOK(readings.heartRate!) ||
        !validators.isBodyTempOK(readings.bodyTemp!) ||
        !validators.isAirQualityOK(readings.airQuality!);
  }

  /// Predict possible diseases
  String predictDisease(CattleHealthReadings readings) {
    if (!readings.hasAllData) {
      return "⚠️ Not enough data for disease prediction";
    }

    List<String> diseases = [];

    // Heat Stress
    if (readings.bodyTemp! > 39.5 && readings.heartRate! > 84) {
      diseases.add("Heat Stress");
    }

    // Hypothermia
    if (readings.bodyTemp! < 38 && readings.heartRate! < 48) {
      diseases.add("Hypothermia");
    }

    // Ketosis
    if (readings.bodyTemp! < 38 && readings.humidity! > 70) {
      diseases.add("Ketosis");
    }

    // Mastitis
    if (readings.ambientTemp! > 30 && readings.humidity! > 70) {
      diseases.add("Mastitis");
    }

    // Shock & Circulatory Collapse
    if (readings.bodyTemp! < 38 && readings.heartRate! > 84) {
      diseases.add("Shock & Circulatory Collapse");
    }

    // Respiratory Issues
    if (readings.airQuality! > 100 && readings.heartRate! > 84) {
      diseases.add("Respiratory Issues");
    }

    if (diseases.isEmpty) {
      return "✅ No specific disease detected. Just monitor cattle.";
    }

    return "Possible Disease(s): ${diseases.join(', ')}";
  }

  /// Get disease prediction for specific field
  String? getFieldDisease(String title, double value) {
    switch (title) {
      case "Ambient Temp":
        if (value > 30) return "Heat Stress Risk";
        if (value < 15) return "Cold Stress Risk";
        break;

      case "Humidity":
        if (value > 70) return "Pneumonia Risk";
        if (value < 40) return "Dehydration Risk";
        break;

      case "Heart Rate":
        if (value > 84) return "Fever / Infection Risk";
        if (value < 48) return "Shock Risk";
        break;

      case "Body Temp":
        if (value > 39.5) return "Fever / Mastitis";
        if (value < 38) return "Hypothermia Risk";
        break;

      case "Air Quality":
        if (value > 100) return "Respiratory Disease Risk";
        break;
    }
    return null;
  }
}
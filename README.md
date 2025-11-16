# 🐄 IoT-Based Cattle Health Monitoring System

## 📌 Introduction
A real-time livestock monitoring system that uses IoT sensors, ThingSpeak Cloud, AI prediction models.
Also, a Flutter Mobile App to help farmers track cattle health, detect risks early, and improve farm productivity.

---

## 📋 Overview
This project provides real-time monitoring of cattle using environmental and biometric sensors connected to an ESP32, with data pushed to ThingSpeak IoT Cloud and visualized through a Flutter mobile application.
An optional AI model predicts potential disease risks based on historical health patterns.

---

## 🎯 Features
### 1️⃣ Real Time Monitoring
- Ambient Temperature
- Humidity
- Body Temperature
- Heart Rate
- Air Quality (MQ-x Gas Sensor)

### 2️⃣ Smart Trent Indicators
Compares latest vs. previous readings and shows:
- 🟢 **Upward Arror** → Improving
- 🔴 **Downward Arrow** → Declining
- ➖ **Stable** → No change

### 3️⃣ Color-Coded Alerts
- Normal → Green
- Warning → Yellow
- Critical → Red

### 4️⃣ Automatic Updates
App refreshes only when new data arrives from ThingSpeak.

### 5️⃣ AI-Driven Disease Prediction
- Risk score based on multi-sensor inputs
- SHAP/LIME-based explanations
- Helps farmers understand “why” a risk is detected

### 6️⃣ Notifications
- Abnormal sensor readings
- Health risk alerts
- Environmental warnings

### 7️⃣ Additional Features
- Offline caching for low-network areas
- Multi-cattle support
- Historical data tracking
- ThingSpeak API integration

---

## 🧱 System Architecture
**Sensors → ESP32 → ThingSpeak Cloud → Flutter App → AI Risk Engine**

### 🛠️ Hardware Used
- DHT11 – Ambient Temp & Humidity
- Heart Rate Sensor
- MQ-x Gas Sensor
- DS18B20/MLX90614 – Body Temperature
- ESP32 WiFi Microcontroller

### ☁️ Cloud
- ThingSpeak IoT Platform
- REST API (GET/POST)
- In-built visualization tools

### 📱 Mobile Application
- Flutter
- Dart
- Provider (State Management)
- HTTP REST calls
- SharedPreferences for offline use

### 🧠 AI Model
- Python (scikit-learn)
- Random Forest / Decision Tree
- SHAP or LIME explanation
- Exported as JSON for use in Flutter

---

## 📱 Flutter App Features in Detail
### Dashboard
- Live sensor values
- Previous data comparison
- Trend arrows
- Health status card

### Alerts Page
- All recent alerts
- Severity levels
- Timestamped logs

 ### AI Prediction Page
- Disease risk score
- Visual explanation
- Suggestions for farmers

 ---

 ### ⚙️ ESP32 Firmware Workflow
 - Collect sensor readings every 60 seconds
 - Format data into ThingSpeak fields
 - Send values using HTTP POST
 - Retry automatically if WiFi drops

--- 

### 🧪 Testing
- Sensor calibration & accuracy checks
- WiFi stability tests
- App performance tests
- API stress testing
- Offline/low-network tests
  
--- 

### 🌍 Impact
This system helps farmers:
- Detect diseases early
- Reduce cattle mortality
- Lower veterinary expenses
- Improve milk & meat productivity
- Reduce stress through automation
- Support large-scale farm management

---

## 📡 ThingSpeak Data Fields

| Field | Data                 |
|-------|----------------------|
| 1     | Ambient Temperature  |
| 2     | Humidity             |
| 3     | Body Temperature     |
| 4     | Pulse Rate           |
| 5     | Air Quality          |
| 6     | (Optional) Gas Level |



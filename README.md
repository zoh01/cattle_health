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

### 2️⃣ Smart Trend Indicators
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
### Data flow
         Sensors → ESP32 → ThingSpeak Cloud → Flutter App → AI Risk Engine

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
### 📡 Dashboard
- Live sensor values
- Previous data comparison
- Trend arrows
- Health status card

### 🔔 Alerts Page
- All recent alerts
- Severity levels
- Timestamped logs

 ### 🤖 AI Prediction Page
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

         | Field | Parameter            | Unit  | Description                                      |
         |-------|-----------------------|-------|--------------------------------------------------|
         | 1     | 🌡️ Ambient Temperature | °C    | Measures the surrounding environmental temperature. |
         | 2     | 💧 Humidity            | %     | Measures moisture level around the cattle.          |
         | 3     | 🌡️ Body Temperature    | °C    | Tracks the internal temperature of the cattle.      |
         | 4     | ❤️ Pulse Rate          | bpm   | Monitors the cattle's heart rate.                   |
         | 5     | 🫁 Air Quality         | AQI   | Detects harmful gases around the cattle.            |
         | 6     | 🧪 Gas Level (Optional)| ppm   | Additional gas measurement depending on sensor used. |

---

## 🚦 Future Improvements
- LoRaWAN support for long-range farms
- GPS tracking for cattle movement
- Solar-powered IoT hardware
- Camera module + image-based disease detection
- Farmer web dashboard

 ---

 ## 📱 App & Device Preview
 
### Complete System
![Complete_System](https://github.com/zoh01/cattle_health/blob/9372e26e2bf2a7e27c19f4da25e1b85a4604d60a/health7.jpeg)

### App Dashboard
![App_Dashboard](https://github.com/zoh01/cattle_health/blob/9372e26e2bf2a7e27c19f4da25e1b85a4604d60a/health4.jpeg)

### AI Disease Predictions
![AI_Disease_Predictions](https://github.com/zoh01/cattle_health/blob/9372e26e2bf2a7e27c19f4da25e1b85a4604d60a/health2.jpeg)

### ThingSpeak Cloud Dashboard
![ThingSpeak_Cloud_Dashboard](https://github.com/zoh01/cattle_health/blob/8708ab3a05895a7cb60b6f5090f81031c5566f71/thingspeak.jpeg)

### Trend Comparison System
![Trend_Comparison](https://github.com/zoh01/cattle_health/blob/9372e26e2bf2a7e27c19f4da25e1b85a4604d60a/health1.jpeg)

### Data Flow
![Data_Flow](https://github.com/zoh01/cattle_health/blob/9837d58b89c2595ff0a979c683179cf9f8ab0114/flow_data.png)

### IoT Hardware Setup
![IoT_Hardware_Setup](https://github.com/zoh01/cattle_health/blob/3a20d45b6b6c5d58b1bcca50eeb8d13fd8265d7a/health6.jpeg)


---

## 🚀 How To Run the Project
Follow the steps below to set up and run the IoT Cattle Health Monitoring System mobile app and IoT hardware.
### 1. 📱 Run the Flutter Mobile App
- Flutter SDK (3.x recommended)
- Android Studio / VS Code
- Dart SDK
- Android Emulator or Physical Device
- Git

**STEPS TO RUN**
1. Clone the repository:
   
            git clone <https://github.com/zoh01/cattle_health>
2. Enter project folder
   
            cd cattle-health-monitoring  
3. Get dependencies
   
            flutter pub get
5. Run the app
   
            flutter run

 ### 2. 🔌 Setup the IoT Hardware (ESP32 + Sensors)
 **Required Components**
 - ESP32
 - DHT11 Sensor (Ambient Temp & Humidity)
 - MQ-x Gas / Air Quality Sensor
 - DS18B20 Temperature Sensor (Body Temp)
 - Pulse Sensor
 - Jumper wires, breadboard & power supply

 **STEPS**
 
 **1. Open the Arduino IDE or PlatformIO.**
 
 **2. Install required ESP32 board packages & sensor libraries.**

 **3. Open the provided esp32_code.ino file from the /iot/ folder.**

**4. Replace the placeholder values with your actual details:**

**STEPS**
ThingSpeak & WiFi Configuration
   
         const char* apiKey = "YOUR_THINGSPEAK_API_KEY";
         const char* wifiSSID = "YOUR_WIFI_SSID";
         const char* wifiPassword = "YOUR_WIFI_PASSWORD";

**5.** Upload the code to the ESP32.

**6.** Sensors will now continuously publish data to **ThingSpeak Cloud**.

### 3. ☁️ Configure ThingSpeak Cloud

**STEPS**

**1. Create a ThingSpeak account**

**2. Create a new channel**

**3. Add fields 1–6:**
- Ambient Temperature
- Humidity
- Body Temperature
- Pulse Rate
- Air Quality
- Gas Level

**4. Copy**
- **Channel ID**
- **Read API Key**
- **Write API Key**
  
**5. Insert these keys into:**
- `Flutter app → api_service.dart`
- ESP32 code → POST requests

### 4. 📡 Connect App to ThingSpeak Data
1. The app automatically fetches data from ThingSpeak API:
   
            https://api.thingspeak.com/channels/YOUR_CHANNEL_ID/feeds.json?results=1
**This populates the dashboard with:**
- Latest Value
- Previous Value
- Trend arrows
- Color-coded status
- Disease prediction

✅ **5. Everything is Ready!**
- Your ESP32 sends data → ThingSpeak
- The Flutter App fetches data → displays real-time health insights
- Disease prediction runs on-device
- Notifications trigger on abnormal values
 
---

## 👤 Author
**Adebayo Wariz**  

## 📧 Contact
Whatsapp: +234 702 513 6608

Email: adebayozoh@gmail.com

LinkedIn: https://www.linkedin.com/in/adebayo-wariz-a8ab9a310/

GitHub: [https://github.com/zoh01](https://github.com/zoh01)

---

## 📄 License
This project is licensed under the MIT License - see [LICENSE](#-LICENSE) file.

    MIT License
    
    Copyright (c) 2025 [Adebayo Wariz]
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction...

---

<div align="center">

### Built with ❤️ using Flutter
⭐ Star this repo if you find it helpful!

</div>


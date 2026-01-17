class DiseaseExplanation {
  final String title;
  final String cause;
  final String advice;

  DiseaseExplanation({
    required this.title,
    required this.cause,
    required this.advice,
  });
}

final Map<String, DiseaseExplanation> diseaseInfo = {
  "No specific disease": DiseaseExplanation(
    title: "Healthy Crop",
    cause: "Environmental and soil conditions are within safe ranges.",
    advice: "Continue regular monitoring and good farm practices.",
  ),

  "Possible Leaf Blight": DiseaseExplanation(
    title: "Leaf Blight",
    cause:
    "Often caused by excessive moisture, fungal infection, or poor air circulation.",
    advice:
    "Reduce irrigation, improve spacing between plants, and apply recommended fungicides.",
  ),

  "Possible Root Rot": DiseaseExplanation(
    title: "Root Rot",
    cause:
    "Caused by overwatering, poor drainage, or infected soil fungi.",
    advice:
    "Improve soil drainage and avoid excessive watering.",
  ),

  "Possible Pest Attack": DiseaseExplanation(
    title: "Pest Infestation",
    cause:
    "High temperature and humidity can encourage insect breeding.",
    advice:
    "Inspect crops regularly and use approved pest control methods.",
  ),
};

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
  "Heat Stress": DiseaseExplanation(
    title: "Heat Stress",
    cause: "Elevated body temperature and heart rate caused by excessive environmental heat.",
    advice: "Move cattle to shade, provide clean water, and reduce physical activity.",
  ),

  "Hypothermia": DiseaseExplanation(
    title: "Hypothermia",
    cause: "Low body temperature and reduced heart rate due to cold exposure.",
    advice: "Provide warmth, dry bedding, and shelter from cold winds.",
  ),

  "Ketosis": DiseaseExplanation(
    title: "Ketosis",
    cause: "Low body temperature combined with high humidity affecting energy metabolism.",
    advice: "Improve nutrition and consult a veterinarian for metabolic support.",
  ),

  "Mastitis": DiseaseExplanation(
    title: "Mastitis",
    cause: "High ambient temperature and humidity encouraging bacterial growth.",
    advice: "Isolate affected cattle and begin veterinary treatment immediately.",
  ),

  "Shock & Circulatory Collapse": DiseaseExplanation(
    title: "Shock & Circulatory Collapse",
    cause: "Low body temperature with abnormally high heart rate indicating stress or trauma.",
    advice: "Urgent veterinary intervention required.",
  ),

  "Respiratory Issues": DiseaseExplanation(
    title: "Respiratory Issues",
    cause: "Poor air quality combined with increased heart rate stressing the lungs.",
    advice: "Improve ventilation and remove cattle from polluted environments.",
  ),
};


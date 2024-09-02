import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
    final int id;
    final String questionText;
    final int surveyId;

    Question({
        required this.id,
        required this.questionText,
        required this.surveyId,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questionText: json["question_text"],
        surveyId: json["survey_id"],
    );

    static List<Question> fromJsonList(String jsonString) {
      Iterable l = jsonDecode(jsonString);
      return List<Question>.from(l.map((model) => Question.fromJson(model)));
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "question_text": questionText,
        "survey_id": surveyId,
    };
}
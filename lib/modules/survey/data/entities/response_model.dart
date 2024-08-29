import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    final List<Answer> answers;
    final int surveyId;

    Response({
        required this.answers,
        required this.surveyId,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        surveyId: json["survey_id"],
    );

    static List<Response> fromJsonList(String jsonString) {
      Iterable l = jsonDecode(jsonString);
      return List<Response>.from(l.map((model) => Response.fromJson(model)));
    }

    Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "survey_id": surveyId,
    };
}

class Answer {
    final int questionId;
    final int selectedOptionId;

    Answer({
        required this.questionId,
        required this.selectedOptionId,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json["question_id"],
        selectedOptionId: json["selected_option_id"],
    );

    static List<Answer> fromJsonList(String jsonString) {
      Iterable l = jsonDecode(jsonString);
      return List<Answer>.from(l.map((model) => Answer.fromJson(model)));
    }

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "selected_option_id": selectedOptionId,
    };
}
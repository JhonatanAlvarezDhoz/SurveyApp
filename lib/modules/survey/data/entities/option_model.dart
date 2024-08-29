import 'dart:convert';

Option optionFromJson(String str) => Option.fromJson(json.decode(str));

String optionToJson(Option data) => json.encode(data.toJson());

class Option {
    final int id;
    final String optionText;
    final int questionId;

    Option({
        required this.id,
        required this.optionText,
        required this.questionId,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionText: json["option_text"],
        questionId: json["question_id"],
    );

    static List<Option> fromJsonList(String jsonString) {
      Iterable l = jsonDecode(jsonString);
      return List<Option>.from(l.map((model) => Option.fromJson(model)));
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "option_text": optionText,
        "question_id": questionId,
    };
}

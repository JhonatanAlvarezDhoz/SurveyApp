import 'dart:convert';

Survey surveyFromJson(String str) => Survey.fromJson(json.decode(str));

String surveyToJson(Survey data) => json.encode(data.toJson());

class Survey {
    final String description;
    final int id;
    final bool isActive;
    final String title;

    Survey({
        required this.description,
        required this.id,
        required this.isActive,
        required this.title,
    });

    factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        description: json["description"],
        id: json["id"],
        isActive: json["is_active"],
        title: json["title"],
    );

    static List<Survey> fromJsonList(String jsonString) {
      Iterable l = jsonDecode(jsonString);
      return List<Survey>.from(l.map((model) => Survey.fromJson(model)));
    }


    Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "is_active": isActive,
        "title": title,
    };
}

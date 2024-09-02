
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../entities/option_model.dart';
import '../entities/question_model.dart';
import '../entities/survey_model.dart';

class SurveyRepository {

  //final String baseUrl = dotenv.get("baseUrl");

  Future<List<Survey>> getSurveys() async {
    final url = Uri.https("deijosedevelop.pythonanywhere.com", "/surveys");
    final response = await http.get(url);
    final surveyList = Survey.fromJsonList(response.body);

    return surveyList;
  }

  Future<List<Question>> getQuestions() async {
    final url = Uri.https("deijosedevelop.pythonanywhere.com", "/questions");
    final response = await http.get(url);
    final questionList = Question.fromJsonList(response.body);

    //throw UnimplementedError();
    return questionList;
  }

  Future<List<Option>> getOptions() async {
    final url = Uri.https("deijosedevelop.pythonanywhere.com", "/options");
    final response = await http.get(url);
    final optionList = Option.fromJsonList(response.body);
    //throw UnimplementedError();
    return optionList;
  }
}

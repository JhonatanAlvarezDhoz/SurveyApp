import 'package:empty_project/modules/survey/data/entities/option_model.dart';
import 'package:empty_project/modules/survey/data/entities/question_model.dart';
import 'package:empty_project/modules/survey/data/entities/survey_model.dart';

abstract class SurveyListEvent {}

class GetSurveyList extends SurveyListEvent {
  final List<Survey> surveyList;

  GetSurveyList({required this.surveyList});
}

class GetQuestionList extends SurveyListEvent {
  final List<Question> questionList;

  GetQuestionList({required this.questionList});
}


class GetOptionList extends SurveyListEvent {
  final List<Option> optionList;

  GetOptionList({required this.optionList});
}


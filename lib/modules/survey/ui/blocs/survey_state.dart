import 'package:empty_project/modules/survey/data/entities/option_model.dart';
import 'package:empty_project/modules/survey/data/entities/question_model.dart';
import 'package:empty_project/modules/survey/data/entities/survey_model.dart';

abstract class SurveyListState {
  List<Survey> surveyList;
  SurveyListState({required this.surveyList});
}

abstract class QuestionListState {
  List<Question> questionList;
  QuestionListState({required this.questionList});
}

abstract class OptionListState {
  List<Option> optionList;
  OptionListState({required this.optionList});
}



class SurveyListInitial extends SurveyListState {
  SurveyListInitial({required super.surveyList});
}

class SurveyListUpdated extends SurveyListState {
  SurveyListUpdated({required super.surveyList});
}

class QuestionListInitial extends QuestionListState {
  QuestionListInitial({required super.questionList});
}

class OptionListInitial extends OptionListState {
  OptionListInitial({required super.optionList});
}
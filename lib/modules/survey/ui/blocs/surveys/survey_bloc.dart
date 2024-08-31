import 'dart:math';

import 'package:empty_project/modules/survey/data/entities/survey_model.dart';
import 'package:empty_project/modules/survey/data/use_cases/get_survey_use_case.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetSurveyUseCase getSurveyUseCase;

  SurveyBloc({
    required this.getSurveyUseCase,
    
  }) : super(SurveyInitial()) {
    on<GetSurvey>(_onGetSurvey);
    
  }

  Future<void> _onGetSurvey(GetSurvey event, Emitter<SurveyState> emit) async {
    emit(SurveyLoading());
    try {
      final surveyList = await getSurveyUseCase();
      final surveyId = getRandomSurveyId(1, surveyList.length);
      final survey = getSurveyById(surveyList, surveyId);

      emit(SurveyLoaded(survey!));
      
    } catch (e) {
      emit(SurveyError(e.toString()));
    }
  }


}

int getRandomSurveyId(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

Survey? getSurveyById(List<Survey> surveyList, int surveyId) {
  return surveyList.firstWhere((survey) => survey.id == surveyId,
      orElse: () => Survey(
          description: 'No existe', id: 0, isActive: true, title: 'No existe'));
}

import 'package:empty_project/modules/survey/data/repositories/survey_repository.dart';
import 'package:empty_project/modules/survey/ui/blocs/survey_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/survey_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurveyListBloc extends Bloc<SurveyListEvent, SurveyListState> {
  SurveyListBloc() : super(SurveyListInitial(surveyList: [])) {
    on<GetSurveyList>(
      (event, emit) {
        emit(SurveyListUpdated(surveyList: state.surveyList));
      },
    );
  }
}

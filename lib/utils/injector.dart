import 'package:empty_project/modules/home/bloc/home_bloc.dart';
import 'package:empty_project/modules/survey/data/repositories/survey_repository.dart';
import 'package:empty_project/modules/survey/data/use_cases/get_survey_use_case.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/questions/question_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => HomeBloc()),
    BlocProvider(create: (_)=> SurveyBloc(
      getSurveyUseCase: GetSurveyUseCase(SurveyRepository()), 
      )
      ),
    BlocProvider(create: (_)=> QuestionListBloc(
      getQuestionsUseCase: GetQuestionsUseCase(SurveyRepository(), ))
    ),
   BlocProvider(create: (_)=> OptionListBloc(getOptionsUseCase: GetOptionsUseCase(SurveyRepository())))
  ];
}

import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/login/bloc/login_bloc.dart';
import 'package:survey_app/modules/login/data/repository/r_login.dart';
import 'package:survey_app/modules/login/data/use_case/uc_login..dart';
import 'package:survey_app/modules/login/data/use_case/uc_register.dart';
import 'package:survey_app/modules/surveys/blocs/survey_blocs/survey_bloc.dart';
import 'package:survey_app/modules/surveys/data/repositories/survey_repository.dart';
import 'package:survey_app/modules/surveys/data/use_cases/get_survey_use_cases.dart';

import '../modules/surveys/blocs/options_blocs/option_bloc.dart';
import '../modules/surveys/blocs/question_blocs/question_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => HomeBloc()),
    BlocProvider(
        create: (_) => LoginBloc(
            registerUseCase: RegisterUseCase(repository: LoginRepository()),
            loginUseCase: LoginUseCase(repository: LoginRepository()))),
    BlocProvider(
        create: (_) => SurveyBloc(
              getSurveyUseCase: GetSurveyUseCase(SurveyRepository()),
            )),
    BlocProvider(
        create: (_) => QuestionListBloc(
                getQuestionsUseCase: GetQuestionsUseCase(
              SurveyRepository(),
            ))),
    BlocProvider(
        create: (_) => OptionListBloc(
            getOptionsUseCase: GetOptionsUseCase(SurveyRepository())))
  ];
}

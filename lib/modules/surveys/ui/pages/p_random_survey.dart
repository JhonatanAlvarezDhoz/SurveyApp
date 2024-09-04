import 'package:survey_app/themes/theme_colors.dart';

import '../../../../routes/app_routes.dart';

import '../../blocs/options_blocs/option_bloc.dart';
import '../../blocs/options_blocs/option_event.dart';

import '../../blocs/question_blocs/question_event.dart';

import '../../blocs/question_blocs/question_bloc.dart';
import '../../blocs/survey_blocs/survey_bloc.dart';
import '../../blocs/survey_blocs/survey_event.dart';
import '../../blocs/survey_blocs/survey_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomSurvey extends StatefulWidget {
  const RandomSurvey({super.key});

  @override
  State<RandomSurvey> createState() => _RandomSurveyState();
}

class _RandomSurveyState extends State<RandomSurvey> {
  late SurveyBloc surveyBloc;
  late QuestionListBloc questionListBloc;
  late OptionListBloc optionListBloc;
  late int questionOrder;
  //late int option;

  @override
  void initState() {
    super.initState();
    questionOrder = 1;
    surveyBloc = BlocProvider.of<SurveyBloc>(context);
    surveyBloc.add(const GetSurvey());
    questionListBloc = BlocProvider.of<QuestionListBloc>(context);
    optionListBloc = BlocProvider.of<OptionListBloc>(context);
    optionListBloc.add(const GetOptionList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
      if (state is SurveyLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SurveyLoaded) {
        print('Survey ID: ${state.survey.id}');
        questionListBloc.add(const GetQuestionList());
        return Card(
          shadowColor: ThemeColors.primary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // This makes the Card size adapt to its content
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  "${state.survey.id}. ${state.survey.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: ThemeColors.primary),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  state.survey.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 14, color: ThemeColors.primaryDark),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes
                                .questions, // The named route for QuestionPage
                            arguments: state
                                .survey.id, // Pass the surveyId as argument
                          );
                        },
                        icon: const Icon(
                          size: 30,
                          Icons.arrow_forward,
                          color: ThemeColors.primary,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return const Center(child: Text('No hay elementos cargados.'));
      }
    });
  }
}

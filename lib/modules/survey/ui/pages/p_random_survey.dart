
import 'package:empty_project/modules/survey/ui/blocs/options/option_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_event.dart';

import 'package:empty_project/modules/survey/ui/blocs/questions/question_event.dart';

import 'package:empty_project/modules/survey/ui/blocs/questions/question_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_state.dart';

import 'package:empty_project/modules/survey/ui/widgets/question_card_widget.dart';
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Random Survey'),
      ),
      body: BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
        if (state is SurveyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurveyLoaded) {
          print('Survey ID: ${state.survey.id}');
          questionListBloc.add(GetQuestionList());
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  state.survey.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.justify,
                  state.survey.description,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                QuestionCard(
                  surveyId: state.survey.id,
                  questionOrder: questionOrder,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      questionOrder > 1 ? questionOrder -= 1 : questionOrder = questionOrder;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),const SizedBox(
                  width: 30,
                ),
                    FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      questionOrder < 10 ? questionOrder += 1 : questionOrder = questionOrder;
                    });
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
                
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                
              ],
            ),
          );
        } else {
          return const Center(child: Text('No hay elementos cargados.'));
        }
      }),
      floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    surveyBloc.add(const GetSurvey());
                  },
                  child: const Icon(Icons.refresh),
                  ),
    )
    );
  }
}





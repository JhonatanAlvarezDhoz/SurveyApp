import 'package:empty_project/modules/survey/data/entities/option_model.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_state.dart';
import 'package:empty_project/modules/survey/ui/blocs/questions/question_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/questions/question_state.dart';
import 'package:empty_project/modules/survey/ui/blocs/questions/question_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/surveys/survey_state.dart';
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
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.justify,
                  state.survey.description,
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
                  children: [
                    FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      questionOrder > 1 ? questionOrder -= 1 : questionOrder = questionOrder;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),const SizedBox(
                  width: 10,
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
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('No hay elementos cargados.'));
        }
      }),
    ));
  }
}

class QuestionCard extends StatefulWidget {
  final int surveyId;
  final int questionOrder;
  const QuestionCard(
      {super.key, required this.surveyId, required this.questionOrder});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionListBloc, QuestionListState>(
      builder: (context, state) {
        if (state is QuestionListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuestionListLoaded) {
          
          final questionList = state.questionList
              .where((question) => question.surveyId == widget.surveyId)
              .toList();
          final question = questionList[widget.questionOrder-1];
          print('Question ID: ${question.id}');
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              //aqui empiezan el contenido de la Card
              child: Options(
                surveyId: widget.surveyId, 
                questionId: question.id, 
                questionOrder: widget.questionOrder, 
                questionText: question.questionText,),
            ),
          );
        } else {
          return const Center(child: Text('No hay elementos cargados.'));
        }
      },
    );
  }
}

class Options extends StatefulWidget {
  final int surveyId;
  final int questionId;
  final int questionOrder;
  final String questionText;
  const Options({
    super.key,
    required this.questionId, required this.questionText, required this.questionOrder, required this.surveyId,
  });

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  Option _selectedOption = Option(id: 0, optionText: '', questionId: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionListBloc, OptionListState>(
        builder: (context, state) {
      if (state is OptionListLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OptionListLoaded) {
        final optionList = state.optionList
            .where((option) => option.questionId == widget.questionId)
            .toList();
            print('Options IDs: ${optionList.toString()}');
        return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.questionOrder}. ${widget.questionText}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: optionList.map((option) {
                      return RadioListTile(
                        title: Text(option.optionText),
                        value: option,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                ],
              );
      } else {
        return const Center(child: Text('No hay elementos cargados.'));
      }
    });
  }
}

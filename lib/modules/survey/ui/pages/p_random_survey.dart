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
  late int question;
  //late int option;

  @override
  void initState() {
    super.initState();
    question = 1;
    //option = 1;
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
          questionListBloc.add(GetQuestionList(state.survey.id));
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
                  question: question,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      question > 1 ? question -= 1 : question = question;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),const SizedBox(
                  width: 10,
                ),
                    FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      question < 10 ? question += 1 : question = question;
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
  final int question;
  const QuestionCard(
      {super.key, required this.surveyId, required this.question});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String _selectedOption = '';

  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];

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
          final question = questionList[widget.question-1];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.question}. ${question.questionText}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: options.map((option) {
                      return RadioListTile(
                        title: Text(option),
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
                  Text(
                    'Opción seleccionada: $_selectedOption',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No hay elementos cargados.'));
        }
      },
    );
  }
}

class Options extends StatelessWidget {
  final int questionId;
  const Options({
    super.key,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionListBloc, OptionListState>(
        builder: (context, state) {
      if (state is OptionListLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OptionListLoaded) {
        final optionList = state.optionList
            .where((option) => option.questionId == questionId)
            .toList();
        return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: optionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${index + 1}. ${optionList[index].optionText}"),
                );
              }),
        );
      } else {
        return const Center(child: Text('No hay elementos cargados.'));
      }
    });
  }
}

import 'package:survey_app/themes/theme_colors.dart';

import '../../blocs/question_blocs/question_bloc.dart';
import '../../blocs/question_blocs/question_state.dart';
import './option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCard extends StatefulWidget {
  final int surveyId;

  const QuestionCard({
    super.key,
    required this.surveyId,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late int questionOrder;

  @override
  void initState() {
    super.initState();
    questionOrder = 1;
  }

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
          final question = questionList[questionOrder - 1];
          print('Question ID: ${question.id}');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shadowColor: ThemeColors.primary,
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
                        questionOrder: questionOrder,
                        questionText: question.questionText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: ThemeColors.primary,
                        heroTag: "1",
                        onPressed: () {
                          setState(() {
                            questionOrder > 1
                                ? questionOrder -= 1
                                : questionOrder = questionOrder;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: ThemeColors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      FloatingActionButton(
                        backgroundColor: ThemeColors.primary,
                        heroTag: "2",
                        onPressed: () {
                          setState(() {
                            questionOrder < 10
                                ? questionOrder += 1
                                : questionOrder = questionOrder;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: ThemeColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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

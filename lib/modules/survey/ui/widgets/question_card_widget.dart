import 'package:empty_project/modules/survey/ui/blocs/questions/question_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/questions/question_state.dart';
import 'package:empty_project/modules/survey/ui/widgets/option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
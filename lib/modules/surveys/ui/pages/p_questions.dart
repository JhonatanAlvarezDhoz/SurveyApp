import 'package:flutter/material.dart';
import '../widgets/question_card_widget.dart';

class QuestionPage extends StatefulWidget {
  final int surveyId;
  const QuestionPage({super.key, required this.surveyId});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Questions"),
      ),
      body: SafeArea(child: QuestionCard(surveyId: widget.surveyId)),
        );
  }
}

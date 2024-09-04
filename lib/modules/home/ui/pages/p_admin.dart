import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/surveys/blocs/survey_blocs/survey_bloc.dart';
import 'package:survey_app/modules/surveys/blocs/survey_blocs/survey_event.dart';
import 'package:survey_app/modules/surveys/blocs/survey_blocs/survey_state.dart';
import 'package:survey_app/modules/surveys/ui/widgets/question_card_widget.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    BlocProvider.of<SurveyBloc>(context).add(GetAllSurveyEvent());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(
      builder: (context, state) {
        return Scaffold(
          body: state is SurveyLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is AllSurveyLoaded
                  ? LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                      final surveyList = state.listsurvey;
                      log(surveyList.toString());
                      return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: constraints.maxHeight * .8,
                          width: constraints.maxWidth,
                          child: SizedBox(
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: constraints.maxHeight * .8,
                                  child: ListView.builder(
                                      itemCount: surveyList.length,
                                      itemBuilder: (context, index) {
                                        return QuestionCard(
                                            surveyId: surveyList[index].id);
                                      }),
                                ),
                              ],
                            )),
                          ));
                    })
                  : state is SurveyError
                      ? const Center(child: Text("Error"))
                      : const SizedBox.shrink(),
        );
      },
    );
  }
}

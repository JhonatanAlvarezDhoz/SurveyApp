import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}



class GetQuestionList extends QuestionEvent {
  final int surveyId;

  const GetQuestionList(this.surveyId);

  @override
  List<Object> get props => [surveyId];
}


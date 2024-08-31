
import 'package:empty_project/modules/survey/data/entities/question_model.dart';

import 'package:equatable/equatable.dart';

class QuestionListState extends Equatable {
  
  const QuestionListState();

  @override
  List<Object?> get props => [];
}

class QuestionListInitial extends QuestionListState {}

class QuestionListLoading extends QuestionListState {}



class QuestionListLoaded extends QuestionListState {
  final List<Question> questionList;

  const QuestionListLoaded(this.questionList);

  @override
  List<Object> get props => [questionList];
}

class QuestionListError extends QuestionListState {
  final String message;

  const QuestionListError(this.message);

  @override
  List<Object> get props => [message];
}

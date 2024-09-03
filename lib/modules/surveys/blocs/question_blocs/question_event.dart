import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}



class GetQuestionList extends QuestionEvent {

  const GetQuestionList();

  @override
  List<Object> get props => [];
}


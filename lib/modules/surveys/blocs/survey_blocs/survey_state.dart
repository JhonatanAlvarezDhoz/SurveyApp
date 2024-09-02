
import 'package:equatable/equatable.dart';

import '../../data/entities/survey_model.dart';

class SurveyState extends Equatable {
  
  const SurveyState();

  @override
  List<Object?> get props => [];
}

class SurveyInitial extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveyLoaded extends SurveyState {
  final Survey survey;

  const SurveyLoaded(this.survey);

  @override
  List<Object> get props => [survey];
}


class SurveyError extends SurveyState {
  final String message;

  const SurveyError(this.message);

  @override
  List<Object> get props => [message];
}

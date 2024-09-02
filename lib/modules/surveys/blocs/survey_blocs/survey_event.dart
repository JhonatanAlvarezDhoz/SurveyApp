import 'package:equatable/equatable.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [];
}

class GetSurvey extends SurveyEvent {
  const GetSurvey();
}


import '../repositories/survey_repository.dart';
import '../entities/survey_model.dart';
import '../entities/option_model.dart';
import '../entities/question_model.dart';

class GetSurveyUseCase {
  final SurveyRepository repository;

  GetSurveyUseCase(
    this.repository,
  );

  Future<List<Survey>> call() async {
    return await repository.getSurveys();
  }
}

class GetQuestionsUseCase {
  final SurveyRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<Question>> call() async {
    return await repository.getQuestions();
  }
}

class GetOptionsUseCase {
  final SurveyRepository repository;
  
  GetOptionsUseCase(this.repository, );

  Future<List<Option>> call() async {
    return await repository.getOptions();
  }
}

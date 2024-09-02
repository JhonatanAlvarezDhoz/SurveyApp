
import '../../data/use_cases/get_survey_use_cases.dart';
import './question_event.dart';
import './question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionListBloc extends Bloc<QuestionEvent, QuestionListState> {
  
  final GetQuestionsUseCase getQuestionsUseCase;
  

  QuestionListBloc({
    
    required this.getQuestionsUseCase,
    
  }) : super(QuestionListInitial()) {
    
    on<GetQuestionList>(_onGetQuestionList);
    
  }

  

  Future<void> _onGetQuestionList(
      GetQuestionList event, Emitter<QuestionListState> emit) async {
    emit(QuestionListLoading());
    try {
      final questions = await getQuestionsUseCase();
      emit(QuestionListLoaded(questions));
    } catch (e) {
      emit(QuestionListError(e.toString()));
    }
  }

  
}

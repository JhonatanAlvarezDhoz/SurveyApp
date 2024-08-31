
import 'package:empty_project/modules/survey/data/use_cases/get_survey_use_case.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_event.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionListBloc extends Bloc<OptionEvent, OptionListState> {
  
  final GetOptionsUseCase getOptionsUseCase;
  

  OptionListBloc({
    
    required this.getOptionsUseCase,
    
  }) : super(OptionListInitial()) {
    
    on<GetOptionList>(_onGetOptionList);
    
  }

  

  Future<void> _onGetOptionList(
      GetOptionList event, Emitter<OptionListState> emit) async {
    emit(OptionListLoading());
    try {
      final options = await getOptionsUseCase();
      emit(OptionListLoaded(options));
    } catch (e) {
      emit(OptionListError(e.toString()));
    }
  }

  
}

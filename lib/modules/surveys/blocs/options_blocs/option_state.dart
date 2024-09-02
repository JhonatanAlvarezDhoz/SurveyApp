
import '../../data/entities/option_model.dart';

import 'package:equatable/equatable.dart';

class OptionListState extends Equatable {
  
  const OptionListState();

  @override
  List<Object?> get props => [];
}

class OptionListInitial extends OptionListState {}

class OptionListLoading extends OptionListState {}



class OptionListLoaded extends OptionListState {
  final List<Option> optionList;

  const OptionListLoaded(this.optionList);

  @override
  List<Object> get props => [optionList];
}

class OptionListError extends OptionListState {
  final String message;

  const OptionListError(this.message);

  @override
  List<Object> get props => [message];
}

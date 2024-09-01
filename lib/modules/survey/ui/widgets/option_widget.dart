import 'package:empty_project/modules/survey/data/entities/option_model.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_bloc.dart';
import 'package:empty_project/modules/survey/ui/blocs/options/option_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Options extends StatefulWidget {
  final int surveyId;
  final int questionId;
  final int questionOrder;
  final String questionText;
  const Options({
    super.key,
    required this.questionId, required this.questionText, required this.questionOrder, required this.surveyId,
  });

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  Option _selectedOption = Option(id: 0, optionText: '', questionId: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionListBloc, OptionListState>(
        builder: (context, state) {
      if (state is OptionListLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OptionListLoaded) {
        final optionList = state.optionList
            .where((option) => option.questionId == widget.questionId)
            .toList();
            print('Options IDs: ${optionList.toString()}');
        return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.questionOrder}. ${widget.questionText}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: optionList.map((option) {
                      return RadioListTile(
                        title: Text(option.optionText),
                        value: option,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                          print('Option Selected: ${_selectedOption.optionText}');
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                ],
              );
      } else {
        return const Center(child: Text('No hay elementos cargados.'));
      }
    });
  }
}
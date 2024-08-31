import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => HomeBloc()),
  ];
}

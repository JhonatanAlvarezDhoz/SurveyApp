import 'package:empty_project/modules/home/bloc/home_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => HomeBloc()),
  ];
}

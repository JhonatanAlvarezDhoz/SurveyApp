import 'package:survey_app/modules/home/bloc/home_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/login/bloc/login_bloc.dart';
import 'package:survey_app/modules/login/data/repository/r_login.dart';
import 'package:survey_app/modules/login/data/use_case/uc_register.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => HomeBloc()),
    BlocProvider(
        create: (_) => LoginBloc(
            registerUseCase: RegisterUseCase(repository: LoginRepository()))),
  ];
}

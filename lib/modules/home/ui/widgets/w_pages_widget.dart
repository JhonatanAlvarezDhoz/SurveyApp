import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/common/constants/storage.dart';
import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:survey_app/modules/home/ui/pages/p_admin.dart';
import 'package:survey_app/modules/home/ui/pages/p_encuesta_base.dart';
import 'package:survey_app/modules/home/ui/pages/p_profile.dart';
import 'package:survey_app/modules/home/ui/pages/p_survey_home.dart';
import 'package:survey_app/utils/secure_storage.dart';

class PagesWidget extends StatelessWidget {
  const PagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return FutureBuilder<String?>(
          future: SecureStorage().readSecureData(
              Storage.role), // Obtén el valor del rol de forma asíncrona
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Muestra un indicador de carga mientras se obtiene el valor
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Maneja cualquier error
              return const Center(child: Text('Error al cargar el rol'));
            } else {
              String? rol = snapshot.data; // Obtén el valor del snapshot
              return PageView(
                controller: state.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  rol == "admin" ? const AdminPage() : const SurveyHome(),
                  const EncuestaBase(),
                  const UserProfile(),
                ],
              );
            }
          },
        );
      },
    );
  }
}

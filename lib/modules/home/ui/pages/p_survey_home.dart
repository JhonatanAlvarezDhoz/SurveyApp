import 'package:flutter/material.dart';
import '../../../surveys/ui/pages/p_random_survey.dart';

class SurveyHome extends StatelessWidget {
  const SurveyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bienvenido Usuario'),
        backgroundColor: Colors.white, // Fondo blanco para AppBar
        elevation: 0, // Eliminar la sombra del AppBar
      ),
      body: const Center(
        child: RandomSurvey(),
      ),
    );
  }
}

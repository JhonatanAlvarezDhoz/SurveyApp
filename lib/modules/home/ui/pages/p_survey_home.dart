import 'package:flutter/material.dart';

class SurveyHome extends StatelessWidget {
  const SurveyHome({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bienvenido Usuario'),
      ),
      body: const Center(
        child: Text('Proximamente Encuestas aqui..!!'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:survey_app/themes/theme_colors.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0.0; // Opacidad inicial

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      // Retraso para iniciar la animación
      setState(() {
        _opacity = 1.0; // Cambiar la opacidad a 1 (visible)
      });
      await validateSession();
    });
    super.initState();
  }

  Future<void> validateSession() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      //TODO: deleted this line with home and descomment navigate to login
      //Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      //Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      //Navigator.of(context).pushReplacementNamed(AppRoutes.homeMessenger);
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: Center(
        child: AnimatedScale(
          scale: _opacity,
          duration: const Duration(seconds: 1), // Duración de la animación
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("assets/images/survey_app_logo.png"),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/modules/common/widgets/w_theme_button.dart';
import 'package:survey_app/routes/app_routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/survey.svg',
                  height: constraints.maxHeight * 0.5,
                ),
                CustomText(
                  text: 'Hola!!',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                gapH12,
                CustomText(
                  text: 'El mejor lugar para dar tu opinion!!',
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  color: Colors.grey,
                ),
                gapH24,
                ThemeButton(
                    text: 'Iniciar Sesion',
                    textSize: 16,
                    buttonSize: Size(constraints.maxWidth * 0.7, 50),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    }),
                gapH12,
                ThemeButton(
                    text: 'Registrate',
                    textSize: 16,
                    buttonSize: Size(constraints.maxWidth * 0.7, 50),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}

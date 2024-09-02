import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/modules/common/widgets/w_rounded_text_form_field.dart';
import 'package:survey_app/modules/common/widgets/w_social_media_icons.dart';
import 'package:survey_app/modules/common/widgets/w_theme_button.dart';
import 'package:survey_app/modules/common/widgets/widgets.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:survey_app/themes/theme_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.formKey});
  final GlobalKey<FormBuilderState> formKey;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: FormBuilder(
          key: widget.formKey,
          child: LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Bienvenido!",
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                        gapH12,
                        CustomText(
                          text: "Ingresa con tus datos!",
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                  gapH48,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedTextFormField(
                        name: 'email',
                        hintText: 'Ingresa tu email',
                        maxWidth: constraints.maxWidth,
                      ),
                      gapH32,
                      RoundedTextFormField(
                        name: 'email',
                        hintText: 'Ingresa tu contraseña',
                        maxWidth: constraints.maxWidth,
                      ),
                      gapH32,
                      ThemeButton(
                        text: 'Iniciar Sesion',
                        buttonSize: const Size(250, 50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      gapH20,
                      CustomText(
                        text: 'Olvidaste tus credenciales??',
                        color: ThemeColors.primary,
                      ),
                    ],
                  ),
                  gapH20,
                  SocialMediaIcons(
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: 'No estas registrado?'),
                        gapW4,
                        GestureDetector(
                          child: CustomText(
                            text: 'Registrate!',
                            color: ThemeColors.primary,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}

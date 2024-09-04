import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_alert_dialog.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/modules/common/widgets/w_outline_theme_button.dart';
import 'package:survey_app/modules/common/widgets/w_rounded_text_form_field.dart';
import 'package:survey_app/modules/common/widgets/w_social_media_icons.dart';
import 'package:survey_app/modules/common/widgets/w_theme_button.dart';
import 'package:survey_app/modules/common/widgets/widgets.dart';
import 'package:survey_app/modules/login/bloc/login_bloc.dart';
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
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginStatus == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    titleText: 'Error',
                    contentText: state.errorText,
                    customActions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedThemeButton(
                            text: "Aceptar",
                            textSize: 18,
                            textWeight: FontWeight.w400,
                            splashColor: ThemeColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            textColor: ThemeColors.primary,
                            borderColor: ThemeColors.tertiary.withOpacity(0.2),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            } else if (state.loginStatus == LoginStatus.success) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    titleText: 'Registro Exitoso',
                    contentText: state.message,
                    svgIcon: SvgPicture.asset('assets/icons/check.svg'),
                    customActions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedThemeButton(
                            text: "Aceptar",
                            textSize: 18,
                            textWeight: FontWeight.w400,
                            splashColor: ThemeColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            textColor: ThemeColors.primary,
                            borderColor: ThemeColors.tertiary.withOpacity(0.2),
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.home),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return FormBuilder(
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
                              name: 'username',
                              hintText: 'Ingresa tu usuario',
                              maxWidth: constraints.maxWidth,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: "El usuario es requerido",
                                ),
                              ]),
                            ),
                            gapH32,
                            RoundedTextFormField(
                              name: 'password',
                              hintText: 'Ingresa tu contraseña',
                              maxWidth: constraints.maxWidth,
                              obscureText: true,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                  errorText: "La contraseña es requerida",
                                ),
                                FormBuilderValidators.minLength(
                                  5,
                                  errorText:
                                      "La contraseña debe tener al menos 5 caracteres.",
                                ),
                              ]),
                            ),
                            gapH32,
                            ThemeButton(
                                text: 'Iniciar Sesion',
                                buttonSize: const Size(250, 50),
                                borderRadius: BorderRadius.circular(8),
                                onPressed: () {
                                  context.read<LoginBloc>().add(LoginSendForm(
                                      loginFormKey: widget.formKey));
                                }),
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
                                  Navigator.pushNamed(
                                      context, AppRoutes.register);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      );
    });
  }
}

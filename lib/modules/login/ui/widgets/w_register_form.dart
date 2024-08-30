import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:survey_app/modules/common/widgets/w_rounded_text_form_field.dart';
import 'package:survey_app/modules/common/widgets/w_social_media_icons.dart';
import 'package:survey_app/modules/common/widgets/w_theme_button.dart';
import 'package:survey_app/modules/common/widgets/widgets.dart';
import 'package:survey_app/modules/login/bloc/login_bloc.dart';
import 'package:survey_app/themes/theme_colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.formKey});
  final GlobalKey<FormBuilderState> formKey;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
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
                              text: "Hola!",
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                            gapH12,
                            CustomText(
                              text: "Crea una nueva cuenta",
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
                            name: 'user_name',
                            hintText: 'Ingresa tu nombre de usuario',
                            maxWidth: constraints.maxWidth,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: "El usuario es requerido",
                              ),
                              FormBuilderValidators.match(
                                RegExp(r'^[a-zA-Z0-9._%+-]{4,9}$'),
                                errorText: "Usuario no válido",
                              ),
                            ]),
                          ),
                          gapH32,
                          RoundedTextFormField(
                            name: 'email',
                            hintText: 'Ingresa tu email',
                            maxWidth: constraints.maxWidth,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: "El email es requerido",
                              ),
                              FormBuilderValidators.email(
                                errorText: "Correo electrónico Inválido",
                              ),
                              FormBuilderValidators.match(
                                RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
                                errorText: "Email no válido",
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
                                8,
                                errorText:
                                    "La contraseña debe tener al menos 8 caracteres.",
                              ),
                              FormBuilderValidators.match(
                                RegExp(
                                    r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$'),
                                errorText:
                                    "La contraseña debe tener al menos 8 caracteres, un carácter especial, un número, una mayúscula y una minúscula.",
                              )
                            ]),
                          ),
                        ],
                      ),
                      gapH32,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ThemeButton(
                            text: 'Registrase',
                            buttonSize: const Size(250, 50),
                            borderRadius: BorderRadius.circular(8),
                            onPressed: () {
                              context.read<LoginBloc>().add(RegisterSendForm(
                                  loginFormKey: widget.formKey));
                            },
                          )
                        ],
                      ),
                      gapH20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: constraints.maxWidth * 0.35,
                              child: const CustomDivider(
                                newColor: ThemeColors.tertiary,
                                size: 1,
                              )),
                          Center(
                              child: CustomText(
                            text: ' o ',
                          )),
                          SizedBox(
                              width: constraints.maxWidth * 0.35,
                              child: const CustomDivider(
                                newColor: ThemeColors.tertiary,
                                size: 1,
                              )),
                        ],
                      ),
                      gapH20,
                      const SocialMediaIcons()
                    ],
                  ),
                );
              }),
            );
          },
        ),
      );
    });
  }
}

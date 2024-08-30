import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/common/widgets/w_custom_app_bar.dart';
import 'package:survey_app/modules/login/ui/widgets/w_register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormBuilderState> registerFormKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: const CustomAppBar(
        actions: [],
      ),
      body: SingleChildScrollView(
        child: RegisterForm(
          formKey: registerFormKey,
        ),
      ),
    );
  }
}

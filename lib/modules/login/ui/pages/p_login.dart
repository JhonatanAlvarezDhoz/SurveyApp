import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/common/widgets/w_custom_app_bar.dart';
import 'package:survey_app/modules/login/ui/widgets/w_login_form.dart';
import 'package:survey_app/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormBuilderState> loginFormKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.welcome, (_) => false);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: LoginForm(
          formKey: loginFormKey,
        ),
      ),
    );
  }
}

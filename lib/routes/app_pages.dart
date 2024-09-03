import 'package:survey_app/modules/home/ui/pages/p_home.dart';
import 'package:survey_app/modules/login/ui/pages/p_login.dart';
import 'package:survey_app/modules/login/ui/pages/p_register.dart';
import 'package:survey_app/modules/login/ui/pages/p_welcome.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());
      case AppRoutes.register:
        return CupertinoPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.welcome:
        return CupertinoPageRoute(builder: (_) => const WelcomePage());

      default:
        return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}

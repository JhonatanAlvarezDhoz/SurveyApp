import 'package:survey_app/modules/home/ui/page/p_home.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());

      default:
        return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}

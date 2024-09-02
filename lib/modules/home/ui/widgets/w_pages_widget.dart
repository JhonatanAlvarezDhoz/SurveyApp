import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:survey_app/modules/home/ui/pages/p_survey_home.dart';

class PagesWidget extends StatelessWidget {
  const PagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return PageView(
          controller: state.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            SurveyHome(),
            //Pagetwo(),
            //PageThree(),
          ],
        );
      },
    );
  }
}

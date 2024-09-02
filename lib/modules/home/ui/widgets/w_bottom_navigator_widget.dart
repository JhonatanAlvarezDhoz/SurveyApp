import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:survey_app/themes/theme_colors.dart';


class BottonNavigatorWidget extends StatelessWidget {
  const BottonNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return BottomNavigationBar(
          //backgroundColor: Colors.transparent,
          currentIndex: state.currentPage,
          selectedItemColor: ThemeColors.primary,
          unselectedItemColor: ThemeColors.primary.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int? page) {
            HomeBloc controller = context.read<HomeBloc>();
            controller.add(ChangePageEvent(page: page));
            controller.state.pageController!.animateToPage(
              page!,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          items: const <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40,
              ),
              label: "Inicio",
              backgroundColor: ThemeColors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fact_check,
                size: 40,
              ),
              label: "Encuesta",
              backgroundColor: ThemeColors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tune,
                size: 40,
              ),
              label: "opciones",
              backgroundColor: ThemeColors.white,
            ),
          ],
        );
      },
    );
  }
}
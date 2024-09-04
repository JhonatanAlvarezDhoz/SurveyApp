import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/modules/common/widgets/w_alert_dialog.dart';
import 'package:survey_app/modules/home/controllers/bloc/home_bloc.dart';
import 'package:survey_app/modules/home/ui/widgets/w_bottom_navigator_widget.dart';
import 'package:survey_app/modules/home/ui/widgets/w_pages_widget.dart';
import 'package:survey_app/modules/login/bloc/login_bloc.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:survey_app/themes/theme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeController;

  @override
  void initState() {
    //context.read<ProfileBloc>().add(const GetProfileLogged());
    homeController = context.read<HomeBloc>();
    context.read<HomeBloc>().add(StartedPageControllerEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    homeController = context.read<HomeBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    homeController.add(const ChangePageEvent(page: 0));
    homeController.add(FinishedPageControllerEvent());
    homeController.state.pageController!.dispose();
    homeController.state.pageController!.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PagesWidget(),
      bottomNavigationBar: const BottonNavigatorWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  contentText: "Cerrar sesión",
                  titleText: "¿Seguro que deseas cerrar la sesión?",
                  onAction: () {
                    context.read<LoginBloc>().add(const LogoutEvent());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.welcome, (_) => false);
                  },
                  onCancel: () => Navigator.of(context).pop(),
                );
              });
        },
        child: const Icon(Icons.logout, color: ThemeColors.white),
      ),
    );
  }
}

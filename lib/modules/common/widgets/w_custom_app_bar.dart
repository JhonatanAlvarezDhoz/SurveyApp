import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final BlocBuilder? blocBuilder; // Mantén el BlocBuilder opcional

  const CustomAppBar({
    super.key,
    this.elevation = 0,
    this.backgroundColor = Colors.white,
    this.leading,
    this.title,
    this.actions,
    this.blocBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final appBarContent = AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      leading: leading ??
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
      title: Center(child: title),
      actions: actions ??
          [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
            ),
          ],
    );

    // Si el blocBuilder está presente, devuelve el blocBuilder, que incluye el appBarContent
    if (blocBuilder != null) {
      return blocBuilder!;
    }

    // Si no se proporciona ningún blocBuilder, devuelve solo la AppBar genérica
    return appBarContent;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

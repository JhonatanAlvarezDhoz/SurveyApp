import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_custom_divider.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/routes/app_routes.dart';
import 'package:survey_app/themes/theme_colors.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key, this.footer});

  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: constraints.maxWidth * 0.46,
                    child: const CustomDivider(
                      newColor: ThemeColors.tertiary,
                      size: 1,
                    )),
                Center(
                    child: CustomText(
                  text: ' o ',
                )),
                SizedBox(
                    width: constraints.maxWidth * 0.46,
                    child: const CustomDivider(
                      newColor: ThemeColors.tertiary,
                      size: 1,
                    )),
              ],
            ),
            gapH12,
            CustomText(text: 'Registrate con tus redes sociales'),
            gapH12,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () {
                    // Handle Google signup
                  },
                ),
                gapW8,
                IconButton(
                  color: Colors.black12,
                  icon: SvgPicture.asset(
                    'assets/icons/facebook.svg',
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {
                    // Handle Facebook signup
                  },
                ),
                gapW8,
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/apple.svg',
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {
                    // Handle Apple signup
                  },
                ),
              ],
            ),
            gapH12,
            footer ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: 'Ya estas registrado?'),
                    gapW4,
                    GestureDetector(
                      child: CustomText(
                        text: 'Inicia Sesion',
                        color: ThemeColors.primary,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                    ),
                  ],
                ),
          ],
        ),
      );
    });
  }
}

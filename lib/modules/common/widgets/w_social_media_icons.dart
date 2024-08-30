import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Column(
        children: [
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
          CustomText(text: 'Ya estas registrado? Inicia Sesion'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:survey_app/modules/common/constants/app_sizes.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/themes/theme_colors.dart';

class CustomCard extends StatelessWidget {
  final BoxConstraints constraints;
  final String title;
  final String description;
  final String numberQuestion;
  const CustomCard({
    super.key,
    required this.constraints,
    required this.title,
    required this.description,
    required this.numberQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(constraints.maxWidth * 0.05),
        height: constraints.maxHeight * 0.3,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              ThemeColors.primary.withOpacity(0.3),
              ThemeColors.primary.withOpacity(0.5),
              ThemeColors.primary.withOpacity(0.8),
              ThemeColors.primary.withOpacity(0.95),
            ],
            stops: const [0.1, 0.3, 0.7, 0.9], // Puntos de parada del gradiente
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.3), // Color del borde
            width: 1.5, // Ancho del borde
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Satisfacción del Cliente",
                  color: ThemeColors.white,
                  fontSize: constraints.maxHeight * 0.03,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 124, 186, 126),
                      borderRadius: BorderRadius.circular(30)),
                )
              ],
            ),
            gapH12,
            CustomText(
              text:
                  "Por favor, complete la encuesta 'Satisfacción del Cliente' para ayudarnos a mejorar nuestros servicios.",
              maxLines: 2,
              color: ThemeColors.white,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
            gapH12,
            SizedBox(
                width: constraints.maxWidth,
                child: CustomText(
                    textAlign: TextAlign.right,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.white,
                    text: "numero de preguntas 4"))
          ],
        ));
  }
}

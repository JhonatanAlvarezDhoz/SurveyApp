import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/themes/theme_colors.dart';

class ThemeButton extends ElevatedButton {
  ThemeButton({
    required this.text,
    super.onPressed,
    this.color = ThemeColors.primary,
    super.key,
    this.borderRadius,
    this.borderColor,
    this.splashColor,
    this.padding,
    this.elevation,
    this.textWeight,
    this.textSize,
    this.textColor,
    this.buttonSize,
    this.withIcon = false,
    this.assetName = "",
  }) : super(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
                fixedSize: MaterialStateProperty.all(buttonSize),
                elevation: MaterialStateProperty.all(elevation ?? 0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        BorderRadius.circular(0), // Botón cuadrado por defecto
                    side: BorderSide(
                        color: borderColor ?? color ?? ThemeColors.white),
                  ),
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                    splashColor ?? ThemeColors.white.withOpacity(0.1)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    color ?? ThemeColors.white)),
            child: SizedBox(
              child: withIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          assetName,
                          width: 30,
                          color: ThemeColors.white,
                        ),
                        CustomText(
                          text: text,
                          color: ThemeColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )
                  : Center(
                      child: FittedBox(
                        child: CustomText(
                          text: text,
                          color: textColor ?? ThemeColors.white,
                          fontWeight: textWeight ?? FontWeight.w900,
                          fontSize: textSize ?? 14,
                        ),
                      ),
                    ),
            ));

  final String text;
  final Color? color;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? splashColor;
  final EdgeInsets? padding;
  final double? elevation;
  final FontWeight? textWeight;
  final double? textSize;
  final Color? textColor;
  final Size? buttonSize;
  final bool withIcon;
  final String assetName;
}

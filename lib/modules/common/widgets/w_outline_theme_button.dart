import 'package:flutter/material.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/themes/theme_colors.dart';


class OutlinedThemeButton extends OutlinedButton {
  OutlinedThemeButton({
    required this.text,
    super.onPressed,
    this.color = ThemeColors.primary,
    this.borderRadius,
    this.borderColor,
    this.splashColor,
    this.padding,
    this.elevation,
    this.textWeight,
    this.textSize,
    this.textColor,
    super.key,
  }) : super(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all<double>(elevation ?? 0),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: borderColor ?? ThemeColors.white),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(20.0),
              ),
            ),
            overlayColor: WidgetStateProperty.all<Color>(
              splashColor ?? ThemeColors.white.withOpacity(0.10),
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomText(
              text: text,
              color: textColor ?? ThemeColors.white,
              fontWeight: textWeight ?? FontWeight.w900,
              fontSize: textSize ?? 14,
            ),
          ),
        );

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
}

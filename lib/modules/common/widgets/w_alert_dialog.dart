import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_app/modules/common/widgets/w_custom_text.dart';
import 'package:survey_app/modules/common/widgets/w_outline_theme_button.dart';
import 'package:survey_app/themes/theme_colors.dart';

// ignore: must_be_immutable
class CustomAlertDialog extends AlertDialog {
  CustomAlertDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    this.onCancel,
    this.onAction,
    this.customActions,
    this.svgIcon,
    this.oneButton,
  }) : super(
          icon: svgIcon ?? SvgPicture.asset('assets/images/alert.svg'),
          title: CustomText(
            text: titleText,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          content: CustomText(
            text: contentText,
            textAlign: TextAlign.center,
            fontSize: 16,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actions: customActions ??
              <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlinedThemeButton(
                      text: "Cancelar",
                      textSize: 18,
                      textWeight: FontWeight.w400,
                      splashColor: ThemeColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                      textColor: ThemeColors.primary,
                      borderColor: ThemeColors.tertiary.withOpacity(0.2),
                      onPressed: onCancel,
                    ),
                    OutlinedThemeButton(
                      text: "Si",
                      textSize: 18,
                      textWeight: FontWeight.bold,
                      splashColor: ThemeColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                      textColor: ThemeColors.primary,
                      borderColor: ThemeColors.primary,
                      onPressed: onAction,
                    ),
                  ],
                )
              ],
          backgroundColor: ThemeColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );

  String titleText;
  String contentText;
  VoidCallback? onCancel;
  VoidCallback? onAction;
  Widget? svgIcon;
  List<Widget>? customActions;
  bool? oneButton;
}

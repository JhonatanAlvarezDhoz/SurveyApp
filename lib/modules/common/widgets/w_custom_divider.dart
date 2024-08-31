import 'package:flutter/material.dart';
import 'package:empty_project/themes/theme_colors.dart';

class CustomDivider extends Divider {
  final Color? newColor;
  final double? size;
  const CustomDivider(
      {this.newColor = ThemeColors.whiteGray, this.size = 3, super.key})
      : super(color: newColor, thickness: size);
}

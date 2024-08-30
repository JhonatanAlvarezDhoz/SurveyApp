import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoundedTextFormField extends FormBuilderTextField {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isFilled;
  final double? maxHeight;
  final double? maxWidth;
  final double? borderWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  final String? initialValue;
  @override
  final bool readOnly;

  RoundedTextFormField({
    required super.name,
    super.keyboardType,
    super.controller,
    super.minLines,
    super.maxLines,
    this.labelText,
    this.hintText,
    super.textAlign,
    this.fontSize,
    this.fontWeight,
    super.validator,
    super.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isFilled = false,
    this.initialValue,
    this.readOnly = false,
    this.maxHeight,
    this.maxWidth,
    this.borderWidth,
    super.onTap,
    super.key,
  }) : super(
            initialValue: initialValue,
            readOnly: readOnly,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                  maxHeight: maxHeight ?? double.infinity,
                  maxWidth: maxWidth ?? double.infinity),
              filled: isFilled,
              hintText: hintText,
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              errorMaxLines: 3,
              errorStyle: const TextStyle(
                color: Color.fromARGB(255, 250, 201, 201),
                overflow: TextOverflow.clip,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              // focusedBorder: isFilled
              //     ? OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: enabledBorderColor ?? ThemeColors.whiteGray,
              //         ),
              //       )
              //     : NoneOutlineInputBorder(),
              // enabledBorder: isFilled
              //     ? OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: enabledBorderColor ?? ThemeColors.whiteGray,
              //         ),
              //       )
              //     : NoneOutlineInputBorder(),
              // border: isFilled
              //     ? OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: enabledBorderColor ?? ThemeColors.whiteGray,
              //         ),
              //       )
              //     : NoneOutlineInputBorder(),
              // fillColor: isFilled
              //     ? enabledFillColor ?? const Color.fromARGB(255, 246, 205, 239)
              //     : Colors.transparent,
              // labelStyle: TextStyle(
              //     fontSize: fontSizeLabel ?? 18,
              //     color: labelColor ?? ThemeColors.tertiary,
              //     fontWeight: labelWeight ?? FontWeight.w500),
              // hintStyle: TextStyle(
              //   fontSize: fontSizeHint ?? 18,
              //   fontWeight: fontWeightHint,
              //   color: hintColor ?? const Color.fromARGB(255, 204, 200, 200),
              // ),
            ));
}

class NoneOutlineInputBorder extends OutlineInputBorder {
  NoneOutlineInputBorder()
      : super(
          borderSide: const NoneBorderSide(),
          borderRadius: BorderRadius.circular(10.0),
        );
}

class NoneBorderSide extends BorderSide {
  const NoneBorderSide()
      : super(
          color: Colors.white,
          width: 0,
          style: BorderStyle.none,
        );
}

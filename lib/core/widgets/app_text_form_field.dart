// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tawbatona/core/utils/text_styles/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.controller,
    this.isObsecureText,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.validator,
    this.suffixIcon,
    this.contentPadding,
    this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final bool? isObsecureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final Function(String)? onFieldSubmitted;
  final String? validator;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecureText ?? false,
      style: TextStyles.font18CanvasMediumGilroy(context),
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
        return null;
      },
      cursorColor: Theme.of(context).canvasColor,
      controller: controller,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
        hintText: hintText,
        hintStyle: TextStyles.font18LighGreyMediumGilroy,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

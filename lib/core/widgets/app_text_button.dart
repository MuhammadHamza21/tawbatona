// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeight,
    required this.onPressed,
    this.child,
    this.title,
  });
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final Function() onPressed;
  final Widget? child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(backgroundColor ?? AppColors.primaryColor),
        foregroundColor:
            MaterialStatePropertyAll(foregroundColor ?? AppColors.whiteColor),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStatePropertyAll(
          Size(double.infinity, 67.h),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.r),
          ),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 12.w,
            vertical: verticalPadding?.w ?? 14.h,
          ),
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(
            buttonWidth ?? double.infinity,
            buttonHeight ?? 50.h,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child ??
          Text(
            title!,
            style: TextStyles.font18WhiteRegularGilroy,
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';
import 'package:tawbatona/core/utils/text_styles/app_font_weights.dart';

class TextStyles {
  static TextStyle font48WhiteRegularGilroy = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 48.sp,
    fontWeight: AppFontWeights.regular,
    height: 1,
    fontFamily: "Gilroy",
  );

  static TextStyle font16BlackRegularGilroyMedium = TextStyle(
    color: AppColors.blackColor,
    fontSize: 16.sp,
    fontWeight: AppFontWeights.regular,
    fontFamily: "Gilroy",
  );

  static TextStyle font18WhiteRegularGilroy = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 16.sp,
    fontWeight: AppFontWeights.regular,
    fontFamily: "Gilroy",
  );

  static TextStyle font26CanvasSemiBoldGolroy(BuildContext context) =>
      TextStyle(
        fontSize: 26.sp,
        color: Theme.of(context).canvasColor,
        fontWeight: AppFontWeights.semiBold,
        fontFamily: "Gilroy",
      );

  static TextStyle font16GreyMediumGilroy = TextStyle(
    fontSize: 16.sp,
    color: AppColors.greyColor,
    fontWeight: AppFontWeights.medium,
    fontFamily: "Gilroy",
  );

  static TextStyle font18LighGreyMediumGilroy = TextStyle(
    fontSize: 18.sp,
    color: AppColors.lightGreyColor,
    fontWeight: AppFontWeights.medium,
    fontFamily: "Gilroy",
  );

  static TextStyle font18CanvasMediumGilroy(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: AppFontWeights.medium,
        fontFamily: "Gilroy",
      );

  static TextStyle font14BlackMediumGilroy() => TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
        fontWeight: AppFontWeights.medium,
        fontFamily: "Gilroy",
      );

  static TextStyle font14GreyMediumGilroy() => TextStyle(
        fontSize: 14.sp,
        color: Colors.grey,
        fontWeight: AppFontWeights.medium,
        fontFamily: "Gilroy",
      );

  static TextStyle font14GreenSemiBoldGilroy = TextStyle(
    fontSize: 14.sp,
    color: AppColors.primaryColor,
    fontWeight: AppFontWeights.semiBold,
    fontFamily: "Gilroy",
  );

  static TextStyle font17RedSemiBoldGilroy = TextStyle(
    fontSize: 17.sp,
    color: Colors.red,
    fontWeight: AppFontWeights.semiBold,
    fontFamily: "Gilroy",
  );

  static TextStyle font16GreenMediumGilroy = TextStyle(
    fontSize: 16.sp,
    color: AppColors.primaryColor,
    fontWeight: AppFontWeights.medium,
    fontFamily: "Gilroy",
  );

  static TextStyle font18GreenMediumGilroy = TextStyle(
    fontSize: 18.sp,
    color: AppColors.primaryColor,
    fontWeight: AppFontWeights.medium,
    fontFamily: "Gilroy",
  );
  static TextStyle font12GreenSemiboldGilroy = const TextStyle(
    fontSize: 12,
    color: AppColors.primaryColor,
    fontWeight: AppFontWeights.semiBold,
    fontFamily: "Gilroy",
  );

  static TextStyle font18DividerSemiboldGilroy(BuildContext context) =>
      TextStyle(
        fontSize: 18.sp,
        color: Theme.of(context).dividerColor,
        fontWeight: AppFontWeights.semiBold,
        fontFamily: "Gilroy",
      );

  static TextStyle font17BlackBoldGilroy() => TextStyle(
        fontSize: 17.5.sp,
        color: Colors.black,
        fontWeight: AppFontWeights.bold,
        fontFamily: "Gilroy",
      );
}

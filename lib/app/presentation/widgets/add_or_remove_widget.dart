import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';

class AddOrRemoveWidget extends StatelessWidget {
  const AddOrRemoveWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });
  final Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Icon(
          icon,
          size: 25.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}

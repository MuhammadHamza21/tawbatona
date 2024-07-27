// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({
    Key? key,
    this.verticalPadding,
    this.horizontalPadding,
    this.color,
    this.strokeWidth,
  }) : super(key: key);

  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 13.h,
            horizontal: horizontalPadding ?? 0),
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth ?? 4,
        ),
      ),
    );
  }
}

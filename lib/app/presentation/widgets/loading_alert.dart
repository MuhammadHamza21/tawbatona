import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';

Future showLoadingAlert({required BuildContext context}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircularProgressIndicatorWidget(),
            SizedBox(width: 15.w),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    },
  );
}

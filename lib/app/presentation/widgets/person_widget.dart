import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/widgets/add_or_remove_widget.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mohamed Hamza",
            style: TextStyles.font17BlackBoldGilroy(),
          ),
          verticalSpacing(5),
          Text(
            "28/7/2024",
            style: TextStyles.font14GreyMediumGilroy(),
          ),
          verticalSpacing(5),
          Row(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Bad word: ",
                    style: TextStyles.font16BlackRegularGilroyMedium,
                  ),
                  TextSpan(
                    text: "54",
                    style: TextStyles.font17RedSemiBoldGilroy,
                  ),
                ]),
              ),
              const Spacer(),
              const Expanded(
                child: SizedBox(),
              ),
              AddOrRemoveWidget(
                icon: Icons.remove,
                onTap: () {},
              ),
              SizedBox(
                width: 10.w,
              ),
              AddOrRemoveWidget(
                icon: Icons.add,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

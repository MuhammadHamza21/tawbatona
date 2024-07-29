// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/app/presentation/screens/add_person_screen.dart';
import 'package:tawbatona/app/presentation/widgets/add_or_remove_widget.dart';
import 'package:tawbatona/app/presentation/widgets/loading_alert.dart';
import 'package:tawbatona/core/utils/navigations/navigate_to.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({
    super.key,
    required this.person,
  });
  final Person person;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          AddPersonScreen(
            person: person,
          ),
        );
      },
      child: Container(
        height: 170.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        margin: EdgeInsets.symmetric(vertical: 10.w),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  person.name,
                  style: TextStyles.font17BlackBoldGilroy(),
                ),
                GestureDetector(
                  onTap: () async {
                    showLoadingAlert(context: context);
                    await AppCubit.get(context).deletePerson(person.id);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
            verticalSpacing(5),
            Text(
              person.date,
              style: TextStyles.font14GreyMediumGilroy(),
            ),
            verticalSpacing(5),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Bad word: ",
                  style: TextStyles.font16BlackRegularGilroyMedium,
                ),
                TextSpan(
                  text: person.noOfBadWords.toString(),
                  style: TextStyles.font17RedSemiBoldGilroy,
                ),
              ]),
            ),
            verticalSpacing(5),
            Row(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "To Pay: ",
                      style: TextStyles.font16BlackRegularGilroyMedium,
                    ),
                    TextSpan(
                      text: person.noOfBadWords.toString(),
                      style: TextStyles.font17RedSemiBoldGilroy,
                    ),
                  ]),
                ),
                const Spacer(),
                const Expanded(
                  child: SizedBox(),
                ),
                // AddOrRemoveWidget(
                //   icon: Icons.remove,
                //   onTap: () {
                //     AppCubit.get(context).updatePerson(UpdatingPersonParams(id: person.id, noOfBadWords: person.noOfBadWords-1, date: "date", amountToPay: amountToPay))
                //   },
                // ),
                // SizedBox(
                //   width: 10.w,
                // ),
                AddOrRemoveWidget(
                  icon: Icons.add,
                  onTap: () {
                    AppCubit.get(context).updatePerson(
                      UpdatingPersonParams(
                        id: person.id,
                        noOfBadWords: person.noOfBadWords + 1,
                        date:
                            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        amountToPay: person.amountToPay + 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

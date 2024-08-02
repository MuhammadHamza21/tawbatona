import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/app/presentation/widgets/person_widget.dart';
import 'package:tawbatona/core/utils/enums/enums.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/app_text_button.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';
import 'package:tawbatona/core/widgets/snackbar_message.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        final appCubit = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: state.gettingPersonsState == RequestState.loading
              ? const CircularProgressIndicatorWidget()
              : state.gettingPersonsState == RequestState.error
                  ? Center(
                      child: Column(
                        children: [
                          Text(
                            "Error",
                            style: TextStyles.font16BlackRegularGilroyMedium,
                          ),
                          verticalSpacing(15),
                          AppTextButton(
                            onPressed: () {
                              appCubit.getPersons();
                            },
                            title: "Try Again",
                          ),
                        ],
                      ),
                    )
                  : state.gettingPersonsState == RequestState.offline
                      ? Center(
                          child: Column(
                            children: [
                              Text(
                                appCubit.gettingPersonsMessage,
                                style:
                                    TextStyles.font16BlackRegularGilroyMedium,
                              ),
                              verticalSpacing(15),
                              AppTextButton(
                                onPressed: () {
                                  appCubit.getPersons();
                                },
                                title: "Try Again",
                              ),
                            ],
                          ),
                        )
                      : state.gettingPersonsState == RequestState.loaded ||
                              state.gettingPersonsState == RequestState.loadMore
                          ? appCubit.personsList.isEmpty
                              ? Center(
                                  child: Text(
                                    "There are no data added yet",
                                    style: TextStyles.font17BlackBoldGilroy(),
                                    maxLines: 2,
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Total to Pay: ",
                                                style: TextStyles
                                                    .font17BlackBoldGilroy(),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${appCubit.getTotalToPay()}",
                                                style: TextStyles
                                                    .font17RedSemiBoldGilroy
                                                    .copyWith(
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " EGP",
                                                style: TextStyles
                                                    .font17BlackBoldGilroy(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              appCubit.personsList.length,
                                          itemBuilder: (context, index) {
                                            return PersonWidget(
                                              person:
                                                  appCubit.personsList[index],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                          : const SizedBox(),
        );
      },
      listener: (context, state) {
        final appCubit = AppCubit.get(context);
        if (state.deletingPersonsState == RequestState.loaded) {
          appCubit.getPersons(isLoadAgain: true);
          SnackbarMessage.showSuccessMessage(context, "Deleted Successfully");
        }
        if (state.deletingPersonsState == RequestState.error) {
          SnackbarMessage.showSuccessMessage(context, "Error while deleting");
        }
        if (state.deletingPersonsState == RequestState.offline) {
          SnackbarMessage.showSuccessMessage(
              context, appCubit.deletingPersonsMessage);
        }
        if (state.updatingPersonsState == RequestState.loaded) {
          appCubit.getPersons(isLoadAgain: true);
          SnackbarMessage.showSuccessMessage(context, "Updated Successfully");
        }
        if (state.updatingPersonsState == RequestState.error) {
          SnackbarMessage.showSuccessMessage(context, "Error while updating");
        }
        if (state.updatingPersonsState == RequestState.offline) {
          SnackbarMessage.showSuccessMessage(
              context, appCubit.updatingPersonsMessage);
        }
      },
    );
  }
}

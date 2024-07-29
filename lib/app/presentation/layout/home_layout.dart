// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/app/presentation/screens/add_person_screen.dart';
import 'package:tawbatona/app/presentation/widgets/person_widget.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';
import 'package:tawbatona/core/utils/enums/enums.dart';
import 'package:tawbatona/core/utils/navigations/navigate_to.dart';

import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/app_text_button.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';
import 'package:tawbatona/core/widgets/snackbar_message.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        surfaceTintColor: Colors.white,
        title: Text(
          "Hello Mohamed",
          style: TextStyles.font16BlackRegularGilroyMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocConsumer<AppCubit, AppState>(
          builder: (context, state) {
            final appCubit = AppCubit.get(context);
            if (state.gettingPersonsState == RequestState.loading) {
              return const CircularProgressIndicatorWidget();
            }
            if (state.gettingPersonsState == RequestState.error) {
              return Center(
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
              );
            }
            if (state.gettingPersonsState == RequestState.offline) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      appCubit.gettingPersonsMessage,
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
              );
            }
            if (state.gettingPersonsState == RequestState.loaded ||
                state.gettingPersonsState == RequestState.loadMore) {
              if (appCubit.personsList.isEmpty) {
                return Center(
                  child: Text(
                    "There are no data added yet",
                    style: TextStyles.font17BlackBoldGilroy(),
                    maxLines: 2,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ListView.builder(
                    itemCount: appCubit.personsList.length,
                    itemBuilder: (context, index) {
                      return PersonWidget(
                        person: appCubit.personsList[index],
                      );
                    },
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            final appCubit = AppCubit.get(context);
            if (state.deletingPersonsState == RequestState.loaded) {
              appCubit.getPersons(isLoadAgain: true);
              SnackbarMessage.showSuccessMessage(
                  context, "Deleted Successfully");
            }
            if (state.deletingPersonsState == RequestState.error) {
              SnackbarMessage.showSuccessMessage(
                  context, "Error while deleting");
            }
            if (state.deletingPersonsState == RequestState.offline) {
              SnackbarMessage.showSuccessMessage(
                  context, appCubit.deletingPersonsMessage);
            }
            if (state.updatingPersonsState == RequestState.loaded) {
              appCubit.getPersons(isLoadAgain: true);
              SnackbarMessage.showSuccessMessage(
                  context, "Updated Successfully");
            }
            if (state.updatingPersonsState == RequestState.error) {
              SnackbarMessage.showSuccessMessage(
                  context, "Error while updating");
            }
            if (state.updatingPersonsState == RequestState.offline) {
              SnackbarMessage.showSuccessMessage(
                  context, appCubit.updatingPersonsMessage);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, const AddPersonScreen());
        },
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

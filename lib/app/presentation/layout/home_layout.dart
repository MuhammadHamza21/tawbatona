// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/app/presentation/screens/add_person_screen.dart';
import 'package:tawbatona/authentication/presentation/controller/authentication_cubit.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';
import 'package:tawbatona/core/utils/navigations/navigate_to.dart';

import 'package:tawbatona/core/utils/text_styles/text_styles.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        final appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0),
            surfaceTintColor: Colors.white,
            title: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return Text(
                  "Hello ${AuthenticationCubit.get(context).user!.displayName!.split(" ").first}",
                  style: TextStyles.font16BlackRegularGilroyMedium,
                );
              },
            ),
          ),
          body: appCubit.screens[appCubit.currentIndex],
          floatingActionButton: appCubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    navigateTo(context, const AddPersonScreen());
                  },
                  backgroundColor: AppColors.primaryColor,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.person_add, color: Colors.white),
                )
              : const SizedBox(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appCubit.currentIndex,
            onTap: (value) {
              appCubit.changeCurrentIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mosque,
                ),
                label: "Athkar",
              ),
            ],
            elevation: 8,
            backgroundColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: AppColors.primaryColor,
              size: 25.sp,
            ),
            unselectedIconTheme: IconThemeData(
              color: AppColors.blackColor,
              size: 25.sp,
            ),
            unselectedLabelStyle: TextStyles.font12GreenSemiboldGilroy
                .copyWith(color: AppColors.blackColor),
            selectedLabelStyle: TextStyles.font12GreenSemiboldGilroy,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.blackColor,
            useLegacyColorScheme: true,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

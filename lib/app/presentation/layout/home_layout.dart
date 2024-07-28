// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/widgets/person_widget.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';

import 'package:tawbatona/core/utils/text_styles/text_styles.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return const PersonWidget();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

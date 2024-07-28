import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/layout/home_layout.dart';
import 'package:tawbatona/authentication/presentation/controller/authentication_cubit.dart';
import 'package:tawbatona/authentication/presentation/screens/login_screen.dart';
import 'package:tawbatona/core/services/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => sl<AuthenticationCubit>()..getCurrentUser()),
        ],
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final authCubit = AuthenticationCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: authCubit.user == null
                  ? const LoginScreen()
                  : const HomeLayout(),
            );
          },
        ),
      ),
    );
  }
}

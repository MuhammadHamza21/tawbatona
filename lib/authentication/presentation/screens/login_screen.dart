import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/layout/home_layout.dart';
import 'package:tawbatona/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:tawbatona/authentication/presentation/controller/authentication_cubit.dart';
import 'package:tawbatona/authentication/presentation/screens/register_screen.dart';
import 'package:tawbatona/core/utils/navigations/navigate_and_finish.dart';
import 'package:tawbatona/core/utils/navigations/navigate_to.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/app_text_button.dart';
import 'package:tawbatona/core/widgets/app_text_form_field.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';
import 'package:tawbatona/core/widgets/snackbar_message.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isObsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyles.font26CanvasSemiBoldGolroy(context),
                ),
                verticalSpacing(10),
                Text(
                  "Enter your email and password",
                  style: TextStyles.font16GreyMediumGilroy,
                ),
                verticalSpacing(30),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyles.font16GreyMediumGilroy,
                      ),
                      verticalSpacing(10),
                      AppTextFormField(
                        controller: emailController,
                        hintText: "Enter your Email",
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: "Enter your Email",
                      ),
                      verticalSpacing(30),
                      Text(
                        "Password",
                        style: TextStyles.font16GreyMediumGilroy,
                      ),
                      verticalSpacing(10),
                      AppTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        autofillHints: const [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator: "Password",
                        isObsecureText: isObsecureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObsecureText = !isObsecureText;
                            });
                          },
                          child: Icon(
                            isObsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        onFieldSubmitted: (p0) {},
                      ),
                    ],
                  ),
                ),
                verticalSpacing(30),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    final authCubit = AuthenticationCubit.get(context);
                    if (state is SignInWithEmailAndPasswordLoadingState) {
                      return const CircularProgressIndicatorWidget();
                    } else {
                      return AppTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            authCubit.signInWithEmailAndPassword(
                              SignInParams(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        title: "Login",
                      );
                    }
                  },
                  listener: (context, state) {
                    final authCubit = AuthenticationCubit.get(context);
                    if (state is SignInWithEmailAndPasswordOfflineState ||
                        state is SignInWithEmailAndPasswordErrorState) {
                      SnackbarMessage.showErrorMessage(
                        context,
                        authCubit.userCredentialsMessage,
                      );
                    } else if (state
                        is SignInWithEmailAndPasswordSuccessState) {
                      SnackbarMessage.showSuccessMessage(
                        context,
                        "Logged in Successfully",
                      );
                      navigateAndFinish(
                        context,
                        const HomeLayout(),
                      );
                    }
                  },
                ),
                verticalSpacing(20),
                Center(
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyles.font14BlackMediumGilroy(),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyles.font14GreenSemiBoldGilroy,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigateTo(
                              context,
                              const RegisterScreen(),
                            );
                          },
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

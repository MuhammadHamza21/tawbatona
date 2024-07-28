import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawbatona/app/presentation/layout/home_layout.dart';
import 'package:tawbatona/authentication/domain/usecases/create_user_with_email_and_password.dart';
import 'package:tawbatona/authentication/domain/usecases/save_user_data.dart';
import 'package:tawbatona/authentication/presentation/controller/authentication_cubit.dart';
import 'package:tawbatona/core/utils/navigations/navigate_and_finish.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/app_text_button.dart';
import 'package:tawbatona/core/widgets/app_text_form_field.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';
import 'package:tawbatona/core/widgets/snackbar_message.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var isObsecureText = true;

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyles.font26CanvasSemiBoldGolroy(context),
                ),
                verticalSpacing(15),
                Text(
                  "Enter your cridentials to continue",
                  style: TextStyles.font16GreyMediumGilroy,
                ),
                verticalSpacing(30),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyles.font16GreyMediumGilroy,
                      ),
                      verticalSpacing(10),
                      AppTextFormField(
                        controller: usernameController,
                        hintText: "Enter your Name",
                        autofillHints: const [AutofillHints.newUsername],
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: "Enter your Name",
                      ),
                      verticalSpacing(30),
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
                        hintText: "Enter your Password",
                        autofillHints: const [AutofillHints.newPassword],
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: "Enter your Password",
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
                      ),
                    ],
                  ),
                ),
                verticalSpacing(30),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    final authCubit = AuthenticationCubit.get(context);
                    if (state is CreateUserWithEmailAndPasswordLoadingState) {
                      return const CircularProgressIndicatorWidget();
                    } else {
                      return AppTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            authCubit.createUserWithEmailAndPassword(
                              CreateUserParams(
                                userName: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        title: "Sign Up",
                      );
                    }
                  },
                  listener: (context, state) {
                    final authCubit = AuthenticationCubit.get(context);
                    if (state is CreateUserWithEmailAndPasswordOfflineState ||
                        state is CreateUserWithEmailAndPasswordErrorState) {
                      SnackbarMessage.showErrorMessage(
                          context, authCubit.userCredentialsMessage);
                    } else if (state
                        is CreateUserWithEmailAndPasswordSuccessState) {
                      navigateAndFinish(
                        context,
                        const HomeLayout(),
                      );
                      authCubit.saveUserData(
                        UserDataParams(
                          userId: authCubit.userCredentials!.user!.uid,
                          userName: usernameController.text,
                          email: emailController.text,
                        ),
                      );
                    }
                  },
                ),
                verticalSpacing(25),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyles.font14BlackMediumGilroy(),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: TextStyles.font14GreenSemiBoldGilroy,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/usecases/add_person.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/core/utils/enums/enums.dart';
import 'package:tawbatona/core/utils/text_styles/text_styles.dart';
import 'package:tawbatona/core/widgets/app_text_button.dart';
import 'package:tawbatona/core/widgets/app_text_form_field.dart';
import 'package:tawbatona/core/widgets/circular_progress_indicator_widget.dart';
import 'package:tawbatona/core/widgets/snackbar_message.dart';
import 'package:tawbatona/core/widgets/spacing.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({
    super.key,
    this.person,
  });
  final Person? person;
  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  var nameController = TextEditingController();

  var noOfBadWordsController = TextEditingController();

  var amountToPayController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.person != null) {
      nameController.text = widget.person!.name;
      noOfBadWordsController.text = widget.person!.noOfBadWords.toString();
      amountToPayController.text = widget.person!.amountToPay.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyles.font17BlackBoldGilroy(),
                ),
                verticalSpacing(10),
                AppTextFormField(
                  controller: nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: "Sorry, you've to enter name!",
                  autofillHints: const [AutofillHints.name],
                ),
                verticalSpacing(20),
                Text(
                  "عدد الشتائم",
                  style: TextStyles.font17BlackBoldGilroy(),
                ),
                verticalSpacing(10),
                AppTextFormField(
                  controller: noOfBadWordsController,
                  hintText: "عدد الشتائم",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                verticalSpacing(20),
                Text(
                  "عليه كام ؟",
                  style: TextStyles.font17BlackBoldGilroy(),
                ),
                verticalSpacing(10),
                AppTextFormField(
                  controller: amountToPayController,
                  hintText: "عليه كام",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                verticalSpacing(30),
                BlocConsumer<AppCubit, AppState>(
                  builder: (context, state) {
                    return AppTextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final appCubit = AppCubit.get(context);
                          if (widget.person == null) {
                            appCubit.addPerson(
                              AddingPersonParams(
                                name: nameController.text,
                                noOfBadWords:
                                    noOfBadWordsController.text.isNotEmpty
                                        ? int.parse(noOfBadWordsController.text)
                                        : 0,
                                amountToPay:
                                    amountToPayController.text.isNotEmpty
                                        ? int.parse(amountToPayController.text)
                                        : 0,
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              ),
                            );
                          } else {
                            appCubit.updatePerson(
                              UpdatingPersonParams(
                                id: widget.person!.id,
                                noOfBadWords:
                                    noOfBadWordsController.text.isNotEmpty
                                        ? int.parse(noOfBadWordsController.text)
                                        : 0,
                                amountToPay:
                                    amountToPayController.text.isNotEmpty
                                        ? int.parse(amountToPayController.text)
                                        : 0,
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              ),
                            );
                          }
                        }
                      },
                      child: state.addingPersonsState == RequestState.loading
                          ? const CircularProgressIndicatorWidget(
                              color: Colors.white,
                              verticalPadding: 0,
                            )
                          : const Text("Save"),
                    );
                  },
                  listener: (context, state) {
                    final appCubit = AppCubit.get(context);
                    if (state.addingPersonsState == RequestState.loaded) {
                      SnackbarMessage.showSuccessMessage(
                        context,
                        "${nameController.text.split(" ").first} has been added successfully",
                      );
                      Navigator.pop(context);
                      AppCubit.get(context).getPersons();
                    } else if (state.addingPersonsState == RequestState.error) {
                      SnackbarMessage.showErrorMessage(
                        context,
                        "Failed to add ${nameController.text.split(" ").first}",
                      );
                    } else if (state.addingPersonsState ==
                        RequestState.offline) {
                      SnackbarMessage.showErrorMessage(
                        context,
                        appCubit.addingPersonsMessage,
                      );
                    }

                    if (state.updatingPersonsState == RequestState.loaded) {
                      SnackbarMessage.showSuccessMessage(
                        context,
                        "${nameController.text.split(" ").first} has been updated successfully",
                      );
                      AppCubit.get(context).getPersons();
                    } else if (state.updatingPersonsState ==
                        RequestState.error) {
                      SnackbarMessage.showErrorMessage(
                        context,
                        "Failed to update ${nameController.text.split(" ").first}",
                      );
                    } else if (state.updatingPersonsState ==
                        RequestState.offline) {
                      SnackbarMessage.showErrorMessage(
                        context,
                        appCubit.updatingPersonsMessage,
                      );
                    }
                  },
                ),
                verticalSpacing(25),
                Center(
                  child: Text(
                    "كل شتيمة بجنيه \n علشان تدفع \n InstaPay: 01020383735 \n Vodafone Cash: 01020383735",
                    style: TextStyles.font17BlackBoldGilroy(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

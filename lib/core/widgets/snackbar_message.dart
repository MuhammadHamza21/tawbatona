import 'package:flutter/material.dart';
import 'package:tawbatona/core/theme/colors/app_colors.dart';

class SnackbarMessage {
  static showErrorMessage(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );

  static showSuccessMessage(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
}

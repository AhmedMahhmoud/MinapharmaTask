import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pharmatask/Core/Colors/app_colors.dart';

class SignSnackbar extends StatelessWidget {
  final String message;
  final bool success;
  const SignSnackbar({super.key, required this.success, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        success
            ? const Icon(
                Icons.check,
                color: CustomColors.successColor,
              )
            : const Icon(
                Icons.error,
                color: CustomColors.errorColor,
              ),
        const SizedBox(
          width: 5,
        ),
        AutoSizeText(message)
      ],
    );
  }
}

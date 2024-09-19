import 'package:flutter/material.dart';
import '/commons/values/colors.dart';

/// Dialogo Pop-Up Standar
void dialogStandardPopUp({
  required BuildContext context,
  required String title,
  required String content,
  required void Function() acceptFunction,
  required void Function() deniedFunction,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: AppColors.appBarColor),
        textAlign: TextAlign.center,
      ),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            acceptFunction();
            Navigator.of(ctx).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.elevatedButtonColor,
            foregroundColor: AppColors.primaryBackground,
          ),
          child: const Text('Conferma'),
        ),
        TextButton(
          onPressed: () {
            deniedFunction();
            Navigator.of(ctx).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryBackground,
            foregroundColor: AppColors.elevatedButtonColor,
          ),
          child: const Text('Annulla'),
        ),
      ],
    ),
  );
}

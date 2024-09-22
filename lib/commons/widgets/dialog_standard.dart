import 'package:flutter/material.dart';

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
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        textAlign: TextAlign.center,
      ),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            acceptFunction();
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          child: const Text('Conferma'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            deniedFunction();
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text('Annulla'),
        ),
      ],
    ),
  );
}

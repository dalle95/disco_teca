import 'package:flutter/material.dart';

/// Widget per l'appBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
}) {
  return AppBar(
    title: Text(
      'Filtro',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    ),
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
  );
}

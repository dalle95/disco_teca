import 'package:flutter/material.dart';

import '/commons/values/colors.dart';

/// Widget della AppBar
PreferredSizeWidget buildAppBar({String title = ''}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textTitleColor,
      ),
    ),
    backgroundColor: AppColors.secondaryBackground,
  );
}

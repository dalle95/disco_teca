import 'package:flutter/material.dart';
import '/commons/values/colors.dart';

// Widget per creare il background
Widget buildBackgroundContainer({required Widget child}) {
  return Container(
    color: AppColors.secondaryBackground,
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    ),
  );
}

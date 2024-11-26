import 'dart:ui';

import 'package:flutter/material.dart';

import '/core/configs/assets/app_images.dart';

class BackGroundView extends StatelessWidget {
  const BackGroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background con effetto vinile
        Positioned.fill(
          child: Image.asset(
            AppImages.splashBackground,
            fit: BoxFit.cover,
          ),
        ),
        // Effetto sfocatura
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

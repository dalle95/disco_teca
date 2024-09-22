import 'package:disco_teca/commons/utils/assets_utils.dart';
import 'package:flutter/material.dart';

Widget loadingView({required BuildContext context}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(getLoadingGifPath()),
        Text(
          'In caricamento..',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    ),
  );
}

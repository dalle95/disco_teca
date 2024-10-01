import 'package:flutter/material.dart';

import '/commons/utils/assets_utils.dart';

Widget buildLoadingView({
  required BuildContext context,
  String title = 'In caricamento..',
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(getLoadingGifPath()),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    ),
  );
}

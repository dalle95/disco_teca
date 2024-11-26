import 'package:flutter/material.dart';

import '/common/helper/assets/assets_utils.dart';

class LoadingView extends StatelessWidget {
  final String title;
  const LoadingView({
    this.title = 'In caricamento..',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

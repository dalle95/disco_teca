import 'package:flutter/material.dart';

/// Widget per l'appBar
class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BasicAppbar({
    required this.title,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(),
      ),
    );
  }
}

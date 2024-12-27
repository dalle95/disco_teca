import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/bloc/theme/theme_cubit.dart';

class ButtonChangeTheme extends StatelessWidget {
  const ButtonChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            context.read<ThemeCubit>().isDarkTheme
                ? Icons.dark_mode
                : Icons.light_mode,
            size: 25,
          ),
          onPressed: () async {
            await context.read<ThemeCubit>().toggleTheme();
          },
        );
      },
    );
  }
}

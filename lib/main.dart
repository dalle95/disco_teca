import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/service_locator.dart';

import '/common/bloc/theme/theme_cubit.dart';

import '/presentation/splash/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/configs/theme/app_theme.dart';
import '/presentation/splash/bloc/splash_cubit.dart';
import '/service_locator.dart';

import '/presentation/splash/pages/splash.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '/presentation/home/bloc/ordine_dischi_cubit.dart';
import '/presentation/home/bloc/search_cubit.dart';
import '/presentation/filtro_dischi/bloc/giri_cubit.dart';
import '/presentation/filtro_dischi/bloc/posizione_cubit.dart';

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
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..appStarted(),
        ),
        BlocProvider(create: (_) => DischiCubit()),
        BlocProvider(create: (_) => OrdineDischiCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => PosizioneCubit()),
        BlocProvider(create: (_) => GiriCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: const SplashPage(),
      ),
    );
  }
}

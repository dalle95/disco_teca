import 'package:app_disco_teca/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/background/background_view.dart';
import '/common/helper/navigation/app_navigation.dart';

import '/presentation/auth/pages/signin.dart';
import '/presentation/splash/bloc/splash_cubit.dart';
import '/presentation/splash/bloc/splash_state.dart';
import '/presentation/download_app/pages/download_app_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(context, SigninPage());
          }

          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, HomePage());
          }

          if (state is DownloadNuovaVersioneApp) {
            AppNavigator.pushReplacement(context, FileDownloadPage());
          }
        },
        child: const BackGroundView(),
      ),
    );
  }
}

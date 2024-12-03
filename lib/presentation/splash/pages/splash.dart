import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/core/configs/assets/app_icons.dart';
import '/core/configs/assets/app_images.dart';

import '/presentation/home/pages/home.dart';
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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.splashBackground,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  AppIcons.logo,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'DiscoTeca',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
